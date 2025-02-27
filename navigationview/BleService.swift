//
//  BleService.swift
//  vcb_client
//
//  Created by Billy Cole on 11/8/22.
//

import Foundation
import UIKit
import CoreBluetooth
import os
import os.log



// MARK: - Application scope singletons
internal let nc = NotificationCenter.default
internal let bleServiceObj = SharedObject.shared.singleBle
internal  let modelObj = SharedModObject.shared.singleMod
internal let MparObj =  SharedMotorValues.shared.singleMotorVal
internal let MotAdjValObj =  SharedmAdjObject.shared.singlemAdj


// MARK: - Publication topics

public extension Notification.Name {
    static let bleStatus  = Notification.Name("bleStatus")
    static let characWriteConfirm = Notification.Name("characWriteConfirm")
    static let characNotifyStateChanged = Notification.Name("characNotifyStateChanged")
    static let characValueChanged = Notification.Name("characValueChanged")   //Callback for Read Command
    static let rssiValueChanged = Notification.Name("rssiValueChanged")
    static let connectStatus = Notification.Name("connectStatus")
}


//
// MARK: - Statuses
//
internal enum BleStatus: CustomStringConvertible {
    case onLine
    case offLine
    case ready
    case connected
    case disconnected
    
    var description: String {
        switch self {
        case .offLine: return "off-line"
        case .onLine: return "on-line"
        case .ready: return "ready"
        case .connected: return "connected"
        case .disconnected: return "disconnected"
            
        }
    }
}

//
//MARK: - Notification Payloads
//
internal struct BleStatusPayload {
    var status: BleStatus
}

internal struct CharacWriteConfirmPayload {
    var charac: CBUUID
}


internal struct CharacNotifyStateChangedPayload {
    var charac: CBUUID
    var state: Bool
}

internal struct CharacValueChangedPayload {
    var charUuid: CBUUID
    var data: Data
}

internal struct RssiValueChangedPayload {
    var value: Int
}


//
//MARK: - Ble Commands
fileprivate enum BleCommand {
    case read
    case write(Data, CBCharacteristicWriteType)
    case setNotify(Bool)
    case readRSSI
}

fileprivate struct ActiveCommand {
    var suuid: CBUUID?
    var cuuid: CBUUID?
    var command: BleCommand = .read
}

//
//MARK: - Timer parameters in seconds
                           
fileprivate let kWatchdogTimeOut        = TimeInterval(435.0) //35.0
fileprivate let scanTimeout             = TimeInterval(420.0) //20.0
fileprivate let connectAttemptTimeout   = TimeInterval(410.0) //10.0
fileprivate let connectionTimeout       = TimeInterval(110.0) //10.0
fileprivate let readRSSITimeout         = TimeInterval(10.5)   //0.5




//MARK: - Error management
//
internal enum BleError: Error {
    case UninitialisedProperty
    case InvalidPayload
    
    var description: String {
        switch self {
        case .UninitialisedProperty: return "Required property is nil"
        case .InvalidPayload: return "Invalid payload"
            
        }
        
    }
}



// MARK: - BleService class <---------------------------------------------------------
//
internal final class BleService: NSObject {
    
    // Last attached peripheral
    private struct LastAttachedPeripheral: Codable {
        var peripheral: UUID
        var suuidData: Data
    }
    
    private let kLastAttachedPeripheralKey = "lap"
    private var userDefaults: UserDefaults

    
    
   // var defaultLog = Logger()
    let customlog = Logger(subsystem: "hi", category: "BlueTooth")
    private var centralManager: CBCentralManager?
    private let initOptions = [ CBCentralManagerOptionShowPowerAlertKey : NSNumber(value: true)]
    
    
    
    //MARK: - Queues
     private let cmdQueue = DispatchQueue(label: "com.brcengineering.vcb_client", qos: .userInitiated)
     private var opQueue = TimedOperationQueue(name: "com.brcengineering.vcb", QoS: .userInitiated, timeout: kWatchdogTimeOut)
    
    // MARK: - Timer
    private let eventTimer = EventTimer()

     // State machine
     private var machine: Machine? = nil
    
     // State maps
     // TODO: state action map init - is an entry per state really needed? Can poss. init with [:]??
     private var stateActionMap: StateActionMap = Dictionary.init(uniqueKeysWithValues: BState.allCases.map { ($0, (nil, nil))})
     private var actionMap: ActionMap = Dictionary.init(uniqueKeysWithValues: BState.allCases.map { ($0, [:])})
     private var errorMap: ErrorMap = Dictionary.init(uniqueKeysWithValues: BState.allCases.map { ($0, (nil, .Start))})
    
     
    private var attachingWith: (peripheral: CBPeripheral?, suuid: CBUUID?, isAttached: Bool) =
                               (nil, nil, false)
    
    
    private var activeCommand = ActiveCommand()
    

    init(defaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = defaults
        super.init()
        
        setupStateMaps()
        machine = Machine.init(actionMap: actionMap, stateActionMap: stateActionMap, errorMap: errorMap)

        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue(label: "com.brcengineering" ,
                                          qos: .userInitiated), options: initOptions)
        
        opQueue.maxConcurrentOperationCount = 1     // Serial queue
        
    }
    
    
    
    
// MARK: - Private functions
    
//
    
    
    
     private func setupStateMaps() {
         
       
         // State action map
         
          stateActionMap[.Start] = (onEntry: performReset, onExit: nil)
          stateActionMap[.Scanning] = (onEntry: performScan, onExit: nil)
          stateActionMap[.Retrieving] = (onEntry: performRetrieve, onExit: nil)
          stateActionMap[.Ready] = (onEntry: performStageOperation, onExit: nil)

          // Action map
         actionMap[.Start]?[.Scan] = (action: performNullAction, nextState: .Scanning)
         actionMap[.Start]?[.Retrieve] = (action: performNullAction, nextState: .Retrieving)
         actionMap[.Start]?[.OffLine] = (action: performNullAction, nextState: nil)
         
         actionMap[.Scanning]?[.ScanSuccess] = (action: performNullAction, nextState: .Ready)
         actionMap[.Scanning]?[.OffLine] = (action: performNullAction, nextState: .Start)
         actionMap[.Scanning]?[.ScanTimeout] = (action: performNullAction, nextState: .Start)
        
         
         actionMap[.Retrieving]?[.RetrieveFail] = (action: performNullAction, nextState: .Scanning)
         actionMap[.Retrieving]?[.ConnectSuccess(nil)] = (action: performNullAction, nextState: .Ready)
         actionMap[.Retrieving]?[.ConnectFail] = (action: performNullAction, nextState: .Start)
         actionMap[.Retrieving]?[.OffLine] = (action: performNullAction, nextState: .Start)
         actionMap[.Retrieving]?[.Disconnected] = (action: performNullAction, nextState: .Scanning)
         
          
          actionMap[.Ready]?[.Read] = (action: performConnect, nextState: .RWNotify)
          actionMap[.Ready]?[.SetNotify] = (action: performConnect, nextState: .RWNotify)
          actionMap[.Ready]?[.Write] = (action: performConnect, nextState: .RWNotify)
          actionMap[.Ready]?[.ReadRSSI] = (action: performConnect, nextState: .ReadRSSI)
          actionMap[.Ready]?[.OffLine] = (action: performNullAction, nextState: .Start)
          actionMap[.Ready]?[.Disconnected] = (action: performNullAction, nextState: nil)
          actionMap[.Ready]?[.DisconnectedWithError] = (action: performNullAction, nextState: nil)
         
         
         
         actionMap[.RWNotify]?[.ConnectSuccess(nil)] = (action: performDiscoverServices, nextState: nil)
         actionMap[.RWNotify]?[.DiscoverServicesSuccess(nil)] = (action: performDiscoverCharacteristics, nextState: nil)
         actionMap[.RWNotify]?[.DiscoverCharacteristicsSuccess(nil)] = (action: performCommand, nextState: .Ready)
         actionMap[.RWNotify]?[.ConnectFail] = (action: performNullAction, nextState: .Ready)
         actionMap[.RWNotify]?[.DiscoverServicesFail] = (action: performNullAction, nextState: .Ready)
         actionMap[.RWNotify]?[.DiscoverCharacteristicsFail] = (action: performNullAction, nextState: .Ready)
         actionMap[.RWNotify]?[.DisconnectedWithError] = (action: performNullAction, nextState: .Ready)
         actionMap[.RWNotify]?[.OffLine] = (action: performNullAction, nextState: .Start)
         actionMap[.RWNotify]?[.Disconnected] = (action: performNullAction, nextState: .Ready)
         
         actionMap[.ReadRSSI]?[.ConnectSuccess(nil)] = (action: performReadRSSI, nextState: .Ready)
         actionMap[.ReadRSSI]?[.ConnectFail] = (action: performNullAction, nextState: .Ready)
         actionMap[.ReadRSSI]?[.DisconnectedWithError] = (action: performNullAction, nextState: .Ready)
         actionMap[.ReadRSSI]?[.OffLine] = (action: performNullAction, nextState: .Start)
         actionMap[.ReadRSSI]?[.Disconnected] = (action: performNullAction, nextState: .Ready)
         
          // Error map
          errorMap[.Start] = (action: performNullAction, nextState: .Start)
          errorMap[.Scanning] = (action: performNullAction, nextState: .Start)
          errorMap[.Ready] = (action: performNullAction, nextState: .Ready)
          errorMap[.Retrieving] = (action: performNullAction, nextState: .Start)
          errorMap[.RWNotify] = (action: performNullAction, nextState: .Ready)
          errorMap[.ReadRSSI] = (action: performNullAction, nextState: .Ready)

               
               
           }
         
         
    
     
     private func handleEvent(event: BEvent) {
         if let mac = machine {
             mac.handleEvent(event: event)
         }
     }
    
    
    private func setLastAttachedPeripheral(defaults: UserDefaults, peripheral: CBPeripheral, suuid: CBUUID) {
        let last = LastAttachedPeripheral(peripheral: peripheral.identifier, suuidData: suuid.data)
        defaults.set(try? JSONEncoder().encode(last), forKey: kLastAttachedPeripheralKey)
    }

    private func getLastAttachedPeripheral(defaults: UserDefaults) -> LastAttachedPeripheral? {
        var retValue: LastAttachedPeripheral? = nil
        if let lapData = defaults.object(forKey: kLastAttachedPeripheralKey) as? Data {
            retValue = try? JSONDecoder().decode(LastAttachedPeripheral.self, from: lapData)
        }
        return retValue
    }
    
    
    private func completeOperation() {
        if let aop = opQueue.operations.first as? AppOperation {
            aop.isExecuting = false
            aop.isFinished  = true
        }
    }


    


// MARK: - Public (Internal) API
    
    
//-----------------------------------------attachPeripheral------------------------------------------------
    func attachPeripheral(suuid: CBUUID, forceScan: Bool = true) {
          attachingWith = (nil, suuid, false)
        cmdQueue.async {self.handleEvent(event: forceScan ? .Scan  : .Retrieve)}
      }
    
    
//-----------------------------------------read command ------------------------------------------------

      
      func read(suuid: CBUUID, cuuid: CBUUID) {
          opQueue.addOperation(AppOperation(queue: cmdQueue,
                                            dispatchBlock: {
                                            self.activeCommand = ActiveCommand(suuid: suuid,
                                                                               cuuid: cuuid,
                                                                               command: .read )
              
                                            self.cmdQueue.async { self.handleEvent(event: .Read) }
          }))

      }
    
    
//-----------------------------------------write command----------------------------------------------------
    
      
      func write(suuid: CBUUID, cuuid: CBUUID, data: Data, response: Bool) {
          opQueue.addOperation(AppOperation(queue: cmdQueue,
                               dispatchBlock: {
                                self.activeCommand = ActiveCommand(suuid: suuid,
                                                                   cuuid: cuuid,
                                                                   command: .write(data, response == true ? .withResponse : .withoutResponse))
              
                                self.cmdQueue.async { self.handleEvent(event: .Write) }
          }))

          }

    
//-----------------------------------------setNotify command ------------------------------------------------

      func setNotify(suuid: CBUUID, cuuid: CBUUID, state: Bool) {
          opQueue.addOperation(AppOperation(queue: cmdQueue,
                                                 dispatchBlock: {
                                                   self.activeCommand = ActiveCommand(suuid: suuid,
                                                                                 cuuid: cuuid,
                                                                                 command: .setNotify(state))
              
                                                   self.cmdQueue.async { self.handleEvent(event: .SetNotify) }
               }))
      }
    
    
    
    
//-----------------------------------------------readRssi request------------------------------------------------
      func readRssi() {
          opQueue.addOperation(AppOperation(queue: cmdQueue,
                                                    dispatchBlock: {
                                                      self.activeCommand = ActiveCommand(suuid: nil,
                                                                                         cuuid: nil,
                                                                                         command: .readRSSI)
                                                      self.cmdQueue.async { self.handleEvent(event: .ReadRSSI) }
                  }))
      }

    
}

//----------------------------------------------------------------------------------------------------------------



// MARK: - Actions : BleService extension
//
extension BleService {
    
 //------------------------------------- // MARK: - performNullAction <----------------------------------------------
    func performNullAction(event: BEvent, state: BState) {
        os_log("Trace: event %s, state %s", log: Log.ble, type: .info, event.description, state.description)
        print("whatup performNullAction")
    }
    
 
    
    //-----------------------------------------// MARK: - performScan <----------------------------------------------

    func performScan(event: BEvent, state: BState) throws {
        os_log("In performScan, event: %s state %s", log: Log.ble, type: .info, event.description, state.description)
        guard let cm = centralManager, let suuid = attachingWith.suuid else {
            throw BleError.UninitialisedProperty
        }
       // let suuid = CBUUID(string: "8215ad95-c7aa-4135-b454-1ca993846a8b")
        attachingWith.peripheral = nil
        eventTimer.scheduleEvent(fromNow: scanTimeout,
                                 onTimeout: {
                                    os_log("Scan timed out", log: Log.ble, type: .info)
                                    cm.stopScan()
                                    self.cmdQueue.async {
                                        self.handleEvent(event: .ScanTimeout)
                                    }},
                                 onCancel: nil)

        
        cm.scanForPeripherals(withServices: [suuid], options: nil)
    }
    
    //-------------------------------------// MARK: - performConnect <----------------------------------------------

    func performConnect(event: BEvent, state: BState) throws {
          os_log("In performConnect, event: %s state %s", log: Log.ble, type: .info, event.description, state.description)
        guard let cm = centralManager, let per = attachingWith.peripheral else {
              throw BleError.UninitialisedProperty
          }
         
        // time alloted to connect to periph
        eventTimer.scheduleEvent(fromNow: connectAttemptTimeout,
                                 onTimeout: {
                                    os_log("Connect attempt timed out", log: Log.ble, type: .info)
                                    cm.cancelPeripheralConnection(per)
                                    },
                                 onCancel: nil)
        
          cm.connect(per, options: nil)
      }
   
    //----------------------------// MARK: - performStageOperation----------------------------------------------

    
    func performStageOperation(thisEvent: BEvent, thisState: BState) {
        os_log("In performStageOperation, event: %s state: %s", log: Log.ble, type: .info, thisEvent.description, thisState.description)
        
        if attachingWith.isAttached == false {
                attachingWith.isAttached = true
                if let per = attachingWith.peripheral, let suuid = attachingWith.suuid {
                    setLastAttachedPeripheral(defaults: userDefaults, peripheral: per, suuid: suuid)
                }
                nc.post(name: .bleStatus, object: BleStatusPayload(status: .ready))
            }
            else {
                completeOperation()
            }
     }
    

    //--------------------------------// MARK: - performRetrieve----------------------------------------------

    
    func performRetrieve(event: BEvent, state: BState) throws {
         os_log("In performRetrieve, event: %s state %s", log: Log.ble, type: .info, event.description, state.description)
        
         guard let cm = centralManager, let suuid = attachingWith.suuid else {
             throw BleError.UninitialisedProperty }
        
         if let lap = getLastAttachedPeripheral(defaults: userDefaults), CBUUID(data: lap.suuidData) == suuid {
             os_log("Retrieving...", log: Log.ble, type: .info)
             if let per = cm.retrievePeripherals(withIdentifiers: [lap.peripheral]).first {
                 per.delegate = self
                 attachingWith.peripheral = per
                 
                 eventTimer.scheduleEvent(fromNow: connectAttemptTimeout,
                                          onTimeout: {
                                             os_log("Connect attempt timed out", log: Log.ble, type: .info)
                                             cm.cancelPeripheralConnection(per)
                                             },
                                          onCancel: nil)
                 
                 cm.connect(per, options: nil)
             }
             else {
                 cmdQueue.async { self.handleEvent(event: .RetrieveFail) }
             }
         }
         else {
             cmdQueue.async { self.handleEvent(event: .RetrieveFail) }
         }
     } // end performRetrieve
    
    //------------------------------------// MARK: - performDiscoverServices---------------------------------------------
    
    func performDiscoverServices(thisEvent: BEvent, thisState: BState) throws {
         os_log("In performDiscoverServices, event: %s state %s", log: Log.ble, type: .info, thisEvent.description, thisState.description)
         guard case BEvent.ConnectSuccess(let payload) = thisEvent, let pl = payload else {
             throw BleError.InvalidPayload }
         guard let suuid = activeCommand.suuid else {
             
             throw BleError.UninitialisedProperty
         }
                 pl.peripheral.discoverServices([suuid])
     }
    
//---------------------------------// MARK: - performDiscoverCharacteristics---------------------------------------
    
    func performDiscoverCharacteristics(thisEvent: BEvent, thisState: BState) throws {
        os_log("In performDiscoverCharacteristics, event: %s state %s", log: Log.ble, type: .info, thisEvent.description, thisState.description)
        guard case BEvent.DiscoverServicesSuccess(let payload) = thisEvent, let pl = payload else {
            throw BleError.InvalidPayload }
        guard let cuuid = activeCommand.cuuid else {
            throw BleError.UninitialisedProperty }
        
        pl.peripheral.discoverCharacteristics([cuuid], for: pl.service)
    }
    
    //------------------------------// MARK: - performCommand-------------------------------------------------

    func performCommand(thisEvent: BEvent, thisState: BState) throws {
        
        
         os_log("In performCommand, event: %s state %s", log: Log.ble, type: .info, thisEvent.description, thisState.description)
        
         guard case BEvent.DiscoverCharacteristicsSuccess(let payload) = thisEvent, let pl = payload else {
             throw BleError.InvalidPayload
             
         }
             switch activeCommand.command {
             case .write(let data, let type):
                 print("testpoint\(data as NSData)") //<--------------------------------- test code ---------------------
                 pl.peripheral.writeValue(data, for: pl.charac, type: type)
             case .setNotify(let state):
                 pl.peripheral.setNotifyValue(state, for: pl.charac)
             case .read:
                 pl.peripheral.readValue(for: pl.charac)
             default:
                 break       // Complete other cases later...
             }
     }
    
    
    //-----------------------------------// MARK: - performReadRSSI-------------------------------------------------

    func performReadRSSI(thisEvent: BEvent, thisState: BState) throws {
        os_log("In performReadRSSI, event: %s state %s", log: Log.ble, type: .info, thisEvent.description, thisState.description)
        guard case BEvent.ConnectSuccess(let payload) = thisEvent, let pl = payload else {throw BleError.InvalidPayload }
        pl.peripheral.readRSSI()
    }

    //-----------------------------------// MARK: - performReset-------------------------------------------------

    func performReset(thisEvent: BEvent, thisState: BState) throws {
        os_log("In performReset, event: %s state %s", log: Log.ble, type: .info, thisEvent.description, thisState.description)

        if case BEvent.OffLine = thisEvent {
            // CoreBluetooth has gone off-line, notify out
            nc.post(name: .bleStatus, object: BleStatusPayload(status: .offLine))
        }

        attachingWith = (nil, nil, false)
        activeCommand = ActiveCommand(suuid: nil, cuuid: nil, command: .read)
        
        for op in opQueue.operations {
            if let aop = op as? AppOperation {
                aop.isExecuting = false
                aop.isFinished = true
            }
        }
    }

    
} //END Actions : BleService extension

//===========================================================================================================



// MARK: - extension BleService: CBCentralManagerDelegate

extension BleService: CBCentralManagerDelegate {
    
   // MARK: Data Callbacks
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
      
     //   os_log ("Central Manager state: %s", log: Log.ble, type: .info, //central.state.hashValue)
        var status: BleStatus  //enum BleStatus - onLine,  offline, ready
        
        switch central.state {
            
        case .poweredOn:
            customlog.info("BlueTooth is online and posting status to Model")
            status = .onLine  // cmdQueue.async { self.handleEvent(event: .OnLine) }
            
        case .poweredOff, .resetting, .unknown, .unsupported:
            //cmdQueue.async { self.handleEvent(event: .OffLine) }
            status = .offLine
        case .unauthorized:
            
            // iOS 13+ requires user authorisation
            os_log("Bluetooth unauthorised - set authorisation in Info.plist", log: Log.ble, type:  .error, central.state.rawValue)
            assertionFailure()
            status = .offLine      // cmdQueue.async { self.handleEvent(event: .OffLine) }
            
        @unknown default:
            os_log("Unknown central state - verify valid states for this iOS version", log: Log.ble,  type: .error, central.state.rawValue)
                 assertionFailure()
                 cmdQueue.async { self.handleEvent(event: .OffLine) }
                 status = .offLine
        }
        
        nc.post(name: .bleStatus, object: BleStatusPayload(status: status))
    }
    
    
  
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
         os_log("In didDiscoverPeripheral: %s", log: Log.ble, type: .info, peripheral.identifier.uuidString)

         eventTimer.cancel()  //cancel timer for scaning
         central.stopScan()   // end scaning for peripheral
         
            
        if attachingWith.peripheral == nil {        // Discard duplicate discoveries
             peripheral.delegate = self
             attachingWith.peripheral = peripheral
             cmdQueue.async { self.handleEvent(event: .ScanSuccess) }
         }
     }
    
    

    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
         os_log("In didConnect: %s", log: Log.ble, type: .info, peripheral.identifier.uuidString)
        
        nc.post(name: .connectStatus, object: BleStatusPayload(status: BleStatus.connected))
         
        let timeout: TimeInterval
        
         if case BleCommand.readRSSI = activeCommand.command
              { timeout = readRSSITimeout }
         else
              { timeout = connectionTimeout }
        
         eventTimer.scheduleEvent(fromNow: timeout,
                                  onTimeout: {
                                     os_log("Connection timed out", log: Log.ble, type: .info)
                                     //central.cancelPeripheralConnection(peripheral)
                                     },
                                  onCancel: nil)
        /**/
        let payload = PPayload(peripheral: peripheral)
        cmdQueue.async { self.handleEvent(event: .ConnectSuccess(payload)) }
        
    }

    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        os_log("In didFailToConnect: %s", log: Log.ble, type: .info, peripheral.identifier.uuidString)
        
        nc.post(name: .connectStatus, object: BleStatusPayload(status: BleStatus.disconnected))
        
        cmdQueue.async { self.handleEvent(event: .ConnectFail) }
        
    }
    
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        os_log("In didFailToConnect: %s", log: Log.ble, type: .info, peripheral.identifier.uuidString)
        
        nc.post(name: .connectStatus, object: BleStatusPayload(status: BleStatus.disconnected))
        
        if error == nil {
            // Intentional disconnect
            cmdQueue.async { self.handleEvent(event: .Disconnected) }
        }
        else {
            // Unexpected disconnect
            os_log("Peripheral disconnected with error", log: Log.ble, type: .error)
            cmdQueue.async { self.handleEvent(event: .DisconnectedWithError) }
        }
        
    }
    
}




// MARK: - extension BleService: CBPeripheralDelegate

extension BleService: CBPeripheralDelegate {
    
    
    //--------------------------------- Callback for discovered Service -----------------------------------
    // MARK: - BleService: CBPeripheral Callback - didDiscoverServices
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil,
            let suuid = activeCommand.suuid,
            let svcs = peripheral.services,
            let thisSvce = (svcs.filter { $0.uuid == suuid }).first else {
                cmdQueue.async { self.handleEvent(event: .DiscoverServicesFail) }
                return }
        
        let payload = PSPayload(peripheral: peripheral, service: thisSvce)
        cmdQueue.async { self.handleEvent(event: .DiscoverServicesSuccess(payload)) }
    }

    //--------------------------------- Callback for discovered Characteristics -----------------------------------
    // MARK: - BleService: CBPeripheral Callback - didDiscoverCharacteristicsFor
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
         guard error == nil,
             let cuuid = activeCommand.cuuid,
             let characs = service.characteristics,
             let thisCharac = (characs.filter { $0.uuid == cuuid }).first else {
                 cmdQueue.async { self.handleEvent(event: .DiscoverCharacteristicsFail) }
                 return
         }
         
         let payload = PSCPayload(peripheral: peripheral, service: service, charac: thisCharac)
         cmdQueue.async { self.handleEvent(event: .DiscoverCharacteristicsSuccess(payload)) }
     }
    
    //--------------------------------- Callback for Write Command ------------------------------------------------

    // MARK: peripheral Callbacks
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
        os_log("In didWriteValueFor: %s", log: Log.ble, type: .info, characteristic.uuid.uuidString)
        
        guard error == nil else {
            os_log("ERROR: writing characteristic value", log: Log.ble, type: .error)
            return
        }
        
        nc.post(name: .characWriteConfirm, object: CharacWriteConfirmPayload(charac: characteristic.uuid))
    }
    
    //--------------------------------- Callback for Set Notifications -----------------------------------
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        os_log("In didUpdateNotificationStateFor: %s", log: Log.ble, type: .info, characteristic.uuid.uuidString)
        
        guard error == nil else {
            os_log("ERROR: updating notification state", log: Log.ble, type: .error)
            return
        }
         
        print("didUpdateNotificationStateFor \(characteristic.uuid)")
        nc.post(name: .characNotifyStateChanged,
                object: CharacNotifyStateChangedPayload(charac: characteristic.uuid,
                                                        state: characteristic.isNotifying))

    }
    
    //--------------------------------- Callback for Read Command ------------------------------------------------
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        os_log("In didUpdateValueFor: %s", log: Log.ble, type: .info, characteristic.uuid.uuidString)
        guard error == nil else {
            os_log("ERROR: updating characteristic value", log: Log.ble, type: .error)
            return
        }
         if let cval = characteristic.value {
            nc.post(name: .characValueChanged,
                    object: CharacValueChangedPayload(charUuid: characteristic.uuid,
                                                      data: cval))
        }
    }   // end didUpdateValueFor
    
    
    
    //--------------------------------- Callback for didReadRSSI Command ------------------------------------------------

    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        os_log("In didReadRSSI: %d", log: Log.ble, type: .info, RSSI.intValue)
        guard error == nil else {
            os_log("ERROR: reading RSSI", log: Log.ble, type: .error)
            return
        }
        
        nc.post(name: .rssiValueChanged,
                object: RssiValueChangedPayload(value: RSSI.intValue))
    }
}

//======================================================================================================================

//
// MARK: State Map Aliases
//
typealias StateActionMap = Dictionary<BState, (onEntry: ((BEvent, BState) throws ->())?, onExit: ((BEvent, BState) throws ->())?)>
typealias ActionMap = Dictionary<BState, Dictionary<BEvent, (action: ((BEvent, BState) throws ->())?, nextState: BState?)>>
typealias ErrorMap = Dictionary<BState, (action: ((BEvent, BState) -> ())?, nextState: BState)>

// MARK: State, Event, Action Enumerations
//

//
// Valid states
//
enum BState: Int, CaseIterable {
    case Start
    case Scanning
    case Retrieving
    case Ready
    case RWNotify
    case ReadRSSI
}

extension BState: CustomStringConvertible {

    var description: String {
        switch self {
        case .Start: return "Start"
        case .Scanning: return "Scanning"
        case .Retrieving: return "Retrieving"
        case .Ready: return "Ready"
        case .RWNotify: return "RWNotify"
        case .ReadRSSI: return "ReadRSSI"
        }
    }
}

//
//
// MARK: Valid events
///
struct PPayload { var peripheral: CBPeripheral }
struct PSPayload { var peripheral: CBPeripheral; var service: CBService }
struct PSCPayload { var peripheral: CBPeripheral; var service: CBService; var charac: CBCharacteristic }

enum BEvent {
    case OnLine             // Bluetooth is powered on and available
    case OffLine            // Bluetooth is not available (several possible reasons)
    case Scan
    case ScanSuccess
    case ScanCancelled
    case ScanTimeout
    case Retrieve
    case RetrieveFail
    case ConnectSuccess(PPayload?)
    case ConnectFail
    case ConnectAttemptTimeout
    case ConnectionTimeout
    case Disconnected
    case DisconnectedWithError
    case Read
    case Write
    case SetNotify
    case ReadRSSI
    case DiscoverServices
    case DiscoverServicesSuccess(PSPayload?)
    case DiscoverServicesFail
    case DiscoverCharacteristics
    case DiscoverCharacteristicsSuccess(PSCPayload?)
    case DiscoverCharacteristicsFail

}

extension BEvent: CustomStringConvertible {

    var description: String {
        switch self {
        case .OnLine: return "OnLine"
        case .OffLine: return "OffLine"
        case .Scan: return "Scan"
        case .ScanSuccess: return "ScanSuccess"
        case .ScanCancelled: return "ScanCancelled"
        case .ScanTimeout: return "Scan Timeout"
        case .Retrieve: return "Retrieve"
        case .RetrieveFail: return "RetrieveFail"
        case .ConnectSuccess: return "Connect Success"
        case .ConnectFail: return "Connect Fail"
        case .ConnectAttemptTimeout: return "Connect Attempt Timeout"
        case .ConnectionTimeout: return "Connection Timeout"
        case .Disconnected: return "Disconnected"
        case .DisconnectedWithError: return "Disconnected With Error"
        case .Read: return "Read"
        case .Write: return "Write"
        case .SetNotify: return "Set Notify"
        case .ReadRSSI: return "Read RSSI"
        case .DiscoverServices: return "Discover Services"
        case .DiscoverServicesSuccess: return "Discover Services Success"
        case .DiscoverServicesFail: return "Discover Services Fail"
        case .DiscoverCharacteristics: return "Discover Characteristics"
        case .DiscoverCharacteristicsSuccess: return "Discover Characteristics Success"
        case .DiscoverCharacteristicsFail: return "Discover Characteristics Fail"
        }
    }
}

extension BEvent: Hashable {
    static func == (lhs: BEvent, rhs: BEvent) -> Bool {
        return lhs.hashValue == rhs.hashValue ? true : false
    }

    func hash(into hasher: inout Hasher) {

        switch self {
        case .OnLine: hasher.combine(0)
        case .OffLine: hasher.combine(1)
        case .Scan: hasher.combine(4)
        case .ScanSuccess: hasher.combine(5)
        case .ScanCancelled: hasher.combine(6)
        case .ScanTimeout: hasher.combine(7)
        case .Retrieve: hasher.combine(2)
        case .RetrieveFail: hasher.combine(3)
        case .ConnectSuccess: hasher.combine(8)
        case .ConnectFail: hasher.combine(9)
        case .ConnectAttemptTimeout: hasher.combine(10)
        case .ConnectionTimeout: hasher.combine(11)
        case .Disconnected: hasher.combine(12)
        case .DisconnectedWithError: hasher.combine(13)
        case .Read: hasher.combine(14)
        case .Write: hasher.combine(15)
        case .SetNotify: hasher.combine(16)
        case .ReadRSSI: hasher.combine(17)
        case .DiscoverServices: hasher.combine(18)
        case .DiscoverServicesSuccess: hasher.combine(19)
        case .DiscoverServicesFail: hasher.combine(20)
        case .DiscoverCharacteristics: hasher.combine(21)
        case .DiscoverCharacteristicsSuccess: hasher.combine(22)
        case .DiscoverCharacteristicsFail: hasher.combine(23)
        }
    }
}

// MARK: Class Machine
//

fileprivate final class Machine {
    
    private var stateActionMap: StateActionMap = [:]
    private var actionMap: ActionMap = [:]
    private var errorMap: ErrorMap = [:]
    private var currentState:BState? = .Start

    // MARK: Initialisation
    //
    init(actionMap: ActionMap, stateActionMap: StateActionMap, errorMap: ErrorMap) {
        self.actionMap = actionMap
        self.stateActionMap = stateActionMap
        self.errorMap = errorMap
    }

    // MARK: Private functions
    //
    /**
     Handle nested event error
     
     State machine concurrently processes two events.  Queueing should ensure that this condition never occurs.  However, in production, if this situation does occur, probably no option but to discard the event and continue
     */
    private func nilStateError() {
        assertionFailure("ERROR: Nested event")
      //  os_log("ERROR: Nested event", log: Log.ble, type: .error)
    }

    // MA`RK: Public (Internal) functions
    /**
     Performs state transition and error management
     
     Action Map rules:
     - For a given event:
      - absence of an entry signifies an invalid event for this state
      - a valid entry with a nil action signifies no transition action to be taken but state entry/exit action should be taken
      - a valid entry with a nil nextState signifies staying in the same state without executing state entry or exit actions

     State Action Map rules:
     - A valid dictionary entry defines the state entry and/or exit actions
     - Entry and/or exit actions only occur if actionMap.nextState != nil
     - Either action may be nil which signifies no action to be taken
     
     Error Map rules:
     - For each state, an error handling function and a next state are specified
                 
     */
    // MARK: State Machine
    
    internal func handleEvent(event: BEvent) {
        // Event processing cannot be nested
        // Ensure that machine is not currently processing an event
        guard let savedState = currentState else {
            nilStateError()
            return
        }
//tCheck for valid event for this state
        guard let actMap = actionMap[savedState]?[event] else {
            errorMap[savedState]?.action?(event, savedState)
            currentState = errorMap[savedState]?.nextState
            assertionFailure("Invalid event \(event) for state \(savedState)")
            return
        }
        
        do {
            // Execute state exit action
            if let _ = actMap.nextState {
                try stateActionMap[savedState]?.onExit?(event, savedState)
            }
            
            // Execute transition action
            try actMap.action?(event, savedState)

            // Enter next state, execute entry action
            if let nxtState = actMap.nextState  {
                currentState = nxtState
                try stateActionMap[nxtState]?.onEntry?(event, nxtState)
            }
            else { currentState = savedState }
        }
        catch {
            os_log("ERROR: %s, Event: %s, State: %s", log: Log.ble, type: .error,error.localizedDescription, event.description, savedState.description)
            assertionFailure(error.localizedDescription)
            errorMap[savedState]?.action?(event, savedState)
            currentState = errorMap[savedState]?.nextState
        }
    } // end handleEvent(event: BEvent)
} //class Machine




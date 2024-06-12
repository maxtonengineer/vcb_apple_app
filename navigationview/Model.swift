//
//  Model.swift
//  vcb_client
//
//  Created by Billy Cole on 11/8/22.
//

import Foundation
import CoreBluetooth
import os

//
// MARK: -  Entiy public names
//
internal let kEntityMotTblFlash      =   "motorSaveBtn"
internal let kEntityMotTblAdjFlash   = "motorAdjSaveBtn"
internal let kEntityEncoder          = "encoder"
internal let kEntityTempSeneor       = "tempSenor"
internal let kEntityPressureSeneor   = "pressureSenor"
internal let kEntityMotTblToRam      = "motor"
internal let kEntityMotTblAdjToRam   = "motorAdjust"
internal let kEntityMotTblRdBack     = "motorRdBack"
internal let kEntityMotTblAdjRdBack  = "motorAdjRdBack"
internal let kEntityCarSpeed         =   "CarSpeed"
internal let kEntityRSSI             = "rssi"
internal let kEntityVcbConfig        = "vcbconfig"
internal let kEntityVcbLearnMode     = "vcbLearnMode"

//
//MARK: - Publication topics
//
public extension Notification.Name {
    
    static let entymotTblFlashTopic        = Notification.Name(kEntityMotTblFlash)
    static let entymotTblAdjFlashTopic     = Notification.Name(kEntityMotTblAdjFlash)
    static let entyPresSeneorTopic         = Notification.Name(kEntityPressureSeneor)
    static let entyEncoderTopic            = Notification.Name(kEntityEncoder)
    static let entyTempSeneorTopic         = Notification.Name(kEntityTempSeneor)
    static let entyMotTblToRamTopic        = Notification.Name(kEntityMotTblToRam)
    static let entyMotTblAdjToRamTopic     = Notification.Name(kEntityMotTblAdjToRam)
    static let entyMotTblRdBackTopic       = Notification.Name(kEntityMotTblRdBack)
    static let entyMotTblAdjRdBackTopic    = Notification.Name(kEntityMotTblAdjRdBack)
    static let entyRSSITopic               = Notification.Name(kEntityRSSI)
    static let entyVcbConfigTopic          = Notification.Name(kEntityVcbConfig)
    static let entyVcbLearnModeTopic       = Notification.Name(kEntityVcbLearnMode)
}


  enum MACH_State {
       case STATE_IDLE(UInt8)
       case STATE_RUN_UHS(UInt8)
       case STATE_RUN_UL(UInt8)
       case STATE_RUN_DHS(UInt8)
       case STATE_RUN_DL(UInt8)
       
   }




//
// Publication Payloads
internal struct BinaryPayload {
    var value: Bool
    var isNotifying: Bool
    var didWrite: Bool
}

internal struct SenorPayload {
    var value: UInt8
    var isNotifying: Bool
    
   
}

internal struct vcbConfigPayload {
    var value: UInt8// State
    var isNotifying: Bool
   // var en: State
}



internal struct TemperurePayload {
    var value: Float
    var isNotifying: Bool
   
}

internal struct PressurePayload {
    var value: Float
    var isNotifying: Bool
   
}


internal struct EncoderPayload {
    var value: Float
    var isNotifying: Bool
   
}

internal struct motorPayload {
    var value: MotorValues
    var isNotifying: Bool
   
}

internal struct motorAdjPayload {
    var value: MotorAdjValues
    var isNotifying: Bool
   
}



internal struct PistonPayload {
    var value: [UInt8]
}

internal struct carSpeedPayload {
    var value: [UInt16]
}

internal struct motorRatePayload {
    var value: [UInt32]
}



internal struct IntegerPayload {
    var value: Int
    var isNotifying: Bool
    var didWrite: Bool
}


//
// MARK: - permissions
 let kPermitRead         = UInt8(0x01)
 let kPermitWrite        = UInt8(0x02)
 let kPermitNotify       = UInt8(0x04)





//fileprivate let ledServiceUuid       =  CBUUID(string: "1215ad95-c7aa-4135-b454-1ca993846ab8")
//fileprivate let redLedUuid           =  CBUUID(string: "19a2f44b-23ae-4379-8990-954ee8e8cc82")
//fileprivate let greenLedUuid         =  CBUUID(string: "58a2f44b-23ae-4379-8990-954ee8e8ccc6")

// MARK: - CBUUID's

////--------------------------------------------------------- BLE VCB CONFIG  UUID'S -------------------------------------------------------------------------------/////
fileprivate let vcbConfigServiceUuid   =  CBUUID(string: "1115ad95-c7dd-4135-c454-1ca939846a11")
fileprivate let vcbConfigCharUuid      =  CBUUID(string: "77462a28-50b9-43c5-afcb-707ecf2f4677")
fileprivate let vcbLearnModeCharUuid   =  CBUUID(string: "88462a28-50b9-43c5-afcb-707ecf2f4688")


////--------------------------------------------------------- Pressure Sensor UUID'S -------------------------------------------------------------------------------/////
fileprivate let pessureServiceUuid   =  CBUUID(string: "0f1e7f04-bfcd-4764-936b-cda0b118e02d")
fileprivate let pressureCharUuid     =  CBUUID(string: "085f2a28-50b9-43c5-9fcb-707ecf2f7746")

////--------------------------------------------------------- Tempreture Sensor UUID'S -------------------------------------------------------------------------------/////
fileprivate let tempSenServiceUuid   =  CBUUID(string: "7bac50d2-1183-45e6-be64-dff828f02953")
fileprivate let tempSenCharUuid      =  CBUUID(string: "2f655a92-b47c-4500-900f-7af780ed078f")

////--------------------------------------------------------- Encoder UUID'S -------------------------------------------------------------------------------/////
fileprivate let encoderServiceUuid   =  CBUUID(string: "8215ad95-c7aa-4135-b454-1ca993846a8b")
fileprivate let encoderCharUuid      =  CBUUID(string: "91a2f44b-23ae-4379-8990-954ee8e8cc28")

////--------------------------------------------------------- Motor Table Driver UUID'S -------------------------------------------------------------------------------/////
 let motorServiceUuid          =  CBUUID(string:  "35f1e0f4-3ad3-4279-adc0-0226cc80121d")

 let motorTblToRamCharUuid     =  CBUUID(string: "a6560e05-0a3e-4dfb-8891-d15d326353b5")
 let motorTblRdBkCharUuid      =  CBUUID(string: "2f4c7ae6-de2a-42cf-bd81-e24bcd15cf2f")
 let motorTblFlashCharUuid     =  CBUUID(string: "f24c7ae6-de2a-42cf-bd18-2eb4dc15cff2")

 let motorTblAdjToRamCharUuid  =  CBUUID(string: "4bf179e5-dd29-41ce-bc17-2db3db14f1ce")
 let motorTblAdjRdBkCharUuid   =  CBUUID(string: "2f4f7eed-dc2b-4ac9-b887-e645c413c221")
 let motorTblAdjFlashCharUuid  =  CBUUID(string: "124c7ae6-de2a-bd19-42cf-2eb4dc15cf12")

///-----------------------------------------------------------------------------------------------

//fileprivate let svcLight             = CBUUID(string: "F000AA70-0451-4000-B000-000000000000")

fileprivate let defaultService =  encoderServiceUuid   //CBUUID(string: "1215ad95-c7aa-4135-b454-1ca993846ab8")

// MARK: - protocol P_Entity

    protocol  P_Entity {
    associatedtype T
    associatedtype U
    
    var name: String { get }
    var topic: Notification.Name { get }
    var bleService: BleService { get }
    var isNotifying: Bool { get set }
    var didWrite: Bool { get set }
    var suuid: CBUUID { get }
    var cuuid: CBUUID { get }
    var permission: UInt8 { get }
    var value: T { get set }
    var bleValue: U { get set }
    
    // Model inbound
    func get()
    func set(value: T, response: Bool)
    func setNotify(state: Bool)
    // Ble inbound
    func valueChanged(data: Data)
    
    mutating func writeConfirm()
    mutating func notifyStateChanged(state: Bool)
    // Publication
    func publish()
}

// MARK: - protocol P_Entity extension

 extension P_Entity {
    // -----------------------------------Client inbound default implementations--------------------------------------
    func get() {
         guard (permission & kPermitRead) == kPermitRead else { return }
        
               bleService.read(suuid: suuid, cuuid: cuuid)
    }
    
    
    func setNotify(state: Bool) {
        guard (permission & kPermitNotify) == kPermitNotify else { return }
        bleService.setNotify(suuid: suuid,
                             cuuid: cuuid,
                             state: state)
        
    }
    
    // Ble inbound default implementations
    mutating func writeConfirm() {
        didWrite = true
        publish()
        didWrite = false

    }
    
    mutating func notifyStateChanged(state: Bool) {
        
        isNotifying = state
        publish()
     
    }
    
}

//--------------------------------------  Class BinaryEntity class -------------------------------------------------

// MARK: - BinaryEntity class
fileprivate class Entity_Binary: P_Entity {
    typealias T = Bool
    typealias U = UInt8
    
//--------------------------------------  Class Properities -------------------------------------------------
    let name: String
    let topic: Notification.Name
    let bleService: BleService
    var isNotifying: Bool = false
    var didWrite: Bool = false
    let suuid: CBUUID
    let cuuid: CBUUID
    let permission: UInt8
    var value: T
    var bleValue: U
    
    //--------------------------------------  Class Construction -------------------------------------------------
    init(name: String, topic: Notification.Name, suuid: CBUUID, cuuid: CBUUID, permission: UInt8, bleService: BleService, defaultValue: T) {
        self.name = name
        self.topic = topic
        self.bleService = bleService
        self.suuid = suuid
        self.cuuid = cuuid
        self.permission = permission
        self.value = defaultValue
        self.bleValue = defaultValue == false ? 0 : 1
    }
    
//--------------------------------------------- Model inbound --------------------------------------------------------
    func set(value: T, response: Bool) {
        guard (permission & kPermitWrite) == kPermitWrite else { return }
        self.value = value
        bleValue  = value == false ? 0 : 1
        bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &bleValue, { Data($0) } ), response: response )
        
        if response == false {
            publish()
        }
    }
   
//------------------------------------------------ Ble inbound --------------------------------------
    func valueChanged(data: Data) {
        guard let result = data.to(type: UInt8.self) else {
                  os_log("ERROR: converting data", log: Log.model, type: .error)
                  return
              }
        
        bleValue = result
        value = result == 0 ? false : true
        publish()
    }
    
//---------------------------- Publication for Binary Enity------------------------------------------
    func publish() {
        nc.post(name: topic, object: BinaryPayload(value: value, isNotifying: isNotifying, didWrite: didWrite))
    }
    
}




//--------------------------------------   readOnlySenorEntity class -------------------------------------------------

// MARK: - readOnlySenorEntity class
 class readOnlySenorEntity: P_Entity {
    
    typealias T = UInt16
    typealias U = UInt16
    
    let convertPres: utility = utility()
    let name: String
    let topic: Notification.Name
    let bleService: BleService
    var isNotifying: Bool = false
    var didWrite: Bool = false
    let suuid: CBUUID
    let cuuid: CBUUID
     
    let permission: UInt8
    var value: T
    var bleValue: T
    
     
    init(name: String, topic: Notification.Name, suuid: CBUUID, cuuid: CBUUID, permission: UInt8, bleService: BleService,  defaultValue: T) {
        self.name = name
        self.topic = topic
        self.bleService = bleService
        self.suuid = suuid
        self.cuuid = cuuid
        self.permission = permission
        self.value = defaultValue
        self.bleValue = 0 //== false ? 0 : 1
    }
    
    
     func dataToUnsignedBytes16(value : Data) -> [UInt16] {
        let count = value.count
        var array = [UInt16](repeating: 0, count: count)
        (value as NSData).getBytes(&array, length:count * MemoryLayout<UInt16>.size)
        return array
    }
     
     func dataToUnsignedBytes8(value : Data) -> [UInt8] {
        let count = value.count
        var array = [UInt8](repeating: 0, count: count)
        (value as NSData).getBytes(&array, length:count * MemoryLayout<UInt8>.size)
        return array
    }

     
     
     func dataToUnsignedBytes<T>(value : Data) -> [T] {
        let count = value.count
         var array = [T](repeating: 0 as! T, count: count)
        (value as NSData).getBytes(&array, length:count * MemoryLayout<T>.size)
        return array
    }
    
    // Model inbound  set<R> (value: R, response: Bool
     
    func set(value: T, response: Bool) {
        print("")
    }
    
    
    // Ble inbound
    func valueChanged(data: Data) {
        
        
    }
    
    func publish() {
        // nc.post(name: topic, object: SenorPayload(value:  self.value, isNotifying: self.isNotifying))
    }
    
    
}




//----------------------------------- MARK: - Entity_tempSenor <--------------------------------------------

    fileprivate class Entity_tempSenor: readOnlySenorEntity {
        typealias U = UInt16
        var bleVal: U = 0
 
        var results: Float = 0.0
  
           override func valueChanged(data: Data) {
                results = data.withUnsafeBytes{$0.load(as: Float.self)}
                print("this is my tempreure data \(results)")
                self.isNotifying = false
                publish()
           }
        
        
        
        //topic = entyTempSeneorTopic
        override func publish() {
            nc.post(name: topic, object: TemperurePayload(value:  self.results, isNotifying: self.isNotifying))
        }
                
    } //end class Entity_tempSenor


//----------------------------------- MARK: - Entity_pressureSenor <--------------------------------------------

fileprivate class Entity_pressureSenor: readOnlySenorEntity {
    
    typealias U = UInt8
  //  var bleVal: U = 0
    var results: Float = 0.0
    
    override func valueChanged(data: Data) {
        
        results = data.withUnsafeBytes{$0.load(as: Float.self)}
        print("this is my pressure data \(results)")
        
        self.isNotifying = false
        publish()
        
    }
    //topic = entyPresSeneorTopic
    override func publish() {
        nc.post(name: topic, object: PressurePayload(value: self.results, isNotifying: self.isNotifying))
    }
    
    
} //end class Entity_pressureSenor

//----------------------------------- MARK: - Entity_encoder <--------------------------------------------

fileprivate class Entity_encoder: readOnlySenorEntity {
    
 
    var results: Float = 0.0
    
    override func valueChanged(data: Data) {
         results = data.withUnsafeBytes{$0.load(as: Float.self)}
         print("this is my encoder data \(results)")
         self.isNotifying = false
         publish()
    }
    
    
    //topic = entyEncoderTopic
    override func publish() {
        nc.post(name: topic, object: EncoderPayload(value: self.results, isNotifying: self.isNotifying))
    }
    
    
} //END class Entity_encoder

//------------------------------------------------------------------------------------------------------------


//------------------------------------------vcbConfigEntity class-----------------------------------------------------
fileprivate class Entity_vcbConfig: readOnlySenorEntity {
    typealias T = UInt8
    var bleVal: U = 0
    var defaultValue: UInt8 = 0
    var results: UInt8 = 0
    var val: T = 0
    //var res: State = .STATE_IDLE(var results)
    
       override func valueChanged(data: Data) {
            results = data.withUnsafeBytes{$0.load(as: UInt8.self)}
            print("this is my vcbConfig data \(results)")
            self.isNotifying = true //<------------------------------------TEST-------------------------------
            publish()
       }
    
   // func set(value: T, response: Bool)     //--------------------------------------------- Model inbound --------------------------------------------------------
     func set(value: T, response: Bool) {
            guard (permission & kPermitWrite) == kPermitWrite else { return }
            self.val = value
            //bleValue  = value == false ? 0 : 1
            bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &self.val, { Data($0) } ), response: response )
            
            if response == false {
                publish()
            }
        }
    
    
    
    
    
    //topic = entyVcbConfigTopic or entyVcbLearnModeTopic
    override func publish() {
        nc.post(name: topic, object: vcbConfigPayload(value:  self.results, isNotifying: self.isNotifying))
    }
            
} //end class Entity_vcbConfig




    
    //
    // MARK: - Entity Enum - VCB Characteristics

//------------ This enum allows us to lookup different Entity types in our dictionaries in the Model Class
    fileprivate enum EntityEnum {
        
 ///-------------------------------  Sensor Enum  Entity Objects------------ ---------------------------------------------------------------------
        case tempSenorEntityEnum(Entity_tempSenor)
        case EncoderEntityEnum(Entity_encoder)
        case pressSenorEntityEnum(Entity_pressureSenor)
        case vcbConfigEntityEnum(Entity_vcbConfig)
        case vcbLearnModeEntityEnum(Entity_Binary)
        
///-------------------------------  Motor Tbl Drivers  Enum  Entity Objects ---------------------------------------------------------------------
        case motorTblToRamEntityEnum(Entity_motorTbl)
        case motorTblRdEntityEnum(Entity_motorTbl)
        case wrMotTblToFlashEntityEnum(Entity_Binary)
        
        case motorTblAdjToRamEntityEnum(Entity_motorTblAdj)
        case motorTblAdjRdEntityEnum(Entity_motorTblAdj)
        case wrMotTblAdjToFlashEntityEnum(Entity_Binary)
        
        //case carSpeedEntityEnum(Entity_carSpeed)
    } // end enum EntityEnum





    
// MARK: - Model class
    //ObservableObject
internal final class Model  {
   
       // private let bleService: BleService
        private var mpar: MotorValues
        private var mAdj: MotorAdjValues
        
        
        private let bleService: BleService
        private let primaryService: CBUUID
        private var bleStatus: BleStatus = .offLine
        
        //Entities that compose the the Model ( The Model has Entities )
        
        // MARK: - Model ENTITY OBJECTS
//-----------------------Motor Tbl  Objects --------------------------------------------------
        private let motorTblToFlash_EntyObj: Entity_Binary
        private let motorTblToRam_EntyObj: Entity_motorTbl
        private let motorTblRdBack_EntyObj: Entity_motorTbl
//-----------------------Sensor Objects --------------------------------------------------
        private let presSeneor_EntyObj:   Entity_pressureSenor
        private let tempreSen_EntyObj:    Entity_tempSenor
        private let encoder_EntyObj:      Entity_encoder
        private let vcbConfig_EntyObj:    Entity_vcbConfig
        private let vcbLearnMode_EntyObj: Entity_Binary
 //----------------------- Motor Tbl Adj Objects --------------------------------------------------
        private let motorTblAdjToRam_EntyObj: Entity_motorTblAdj // not created yet
        private let motorTblAdjToFlash_EntyObj: Entity_Binary
        private let motorTblAdjRdBack_EntyObj: Entity_motorTblAdj
        
        
//--------------- Dicionaries that Model instances use to lookup Entities for calls made from the UI or BleService
        private let lookUpByEntity: [String : EntityEnum]
        private let lookUpByCharacUuid: [CBUUID : EntityEnum]
        
  
            
//---------------------Constructor for the entiy objects which compose the Model ----------------------------------
        init(mAdj:MotorAdjValues, mpar: MotorValues,bleService: BleService, primaryService: CBUUID = defaultService) {
            self.mAdj = mAdj
            self.mpar = mpar
            self.bleService = bleService
            self.primaryService = primaryService
            
            
            motorTblToFlash_EntyObj = Entity_Binary(name: kEntityMotTblFlash,
                                  topic: .entymotTblFlashTopic,
                                  suuid: motorServiceUuid,
                                  cuuid: motorTblFlashCharUuid,
                                  permission: kPermitRead | kPermitWrite,
                                  bleService: bleService,
                                  defaultValue: false)
            
            
//------------------------------------------- motorTblAdjToFlash_EntyObj ----------------------------
            motorTblAdjToFlash_EntyObj = Entity_Binary(name: kEntityMotTblAdjFlash,
                                  topic: .entymotTblAdjFlashTopic,
                                  suuid: motorServiceUuid,
                                  cuuid: motorTblAdjFlashCharUuid,
                                  permission: kPermitRead | kPermitWrite,
                                  bleService: bleService,
                                  defaultValue: false)

//------------------------------------------- Pressure Senor Object ----------------------------
            presSeneor_EntyObj = Entity_pressureSenor(name: kEntityPressureSeneor,
                                                     topic: .entyPresSeneorTopic,
                                                     suuid: pessureServiceUuid,
                                                     cuuid: pressureCharUuid,
                                                     permission: kPermitRead | kPermitNotify,
                                                     bleService: bleService,
                                                     defaultValue: 0)
//------------------------------------------- Encoder Object ----------------------------------
            encoder_EntyObj = Entity_encoder(name: kEntityEncoder,
                                                  topic: .entyEncoderTopic,
                                                  suuid: encoderServiceUuid,
                                                  cuuid: encoderCharUuid,
                                                  permission: kPermitRead | kPermitNotify,
                                                  bleService: bleService,
                                                  defaultValue: 0)
//------------------------------------------- Temprature Senor Object ----------------------------
            tempreSen_EntyObj = Entity_tempSenor(name: kEntityTempSeneor,
                                                    topic: .entyTempSeneorTopic,
                                                    suuid: tempSenServiceUuid,
                                                    cuuid: tempSenCharUuid,
                                                    permission: kPermitRead | kPermitNotify,
                                                    bleService: bleService,
                                                    defaultValue: 0)

//------------------------------------------- Motor tbl  Object ----------------------------
           motorTblToRam_EntyObj = Entity_motorTbl(name: kEntityMotTblToRam,
                                                    topic: .entyMotTblToRamTopic,
                                                    suuid: motorServiceUuid,
                                                    cuuid: motorTblToRamCharUuid,
                                                    permission: kPermitRead | kPermitNotify | kPermitWrite,
                                                    bleService: bleService,
                                                             defaultValue: MotorValues())
            
            
//----------------------- Motor tbl  Object  used to write adjusted data to VCB RAM----------------------------
            
            motorTblAdjToRam_EntyObj = Entity_motorTblAdj(name: kEntityMotTblAdjToRam,
                                          topic: .entyMotTblAdjToRamTopic,
                                          suuid: motorServiceUuid,
                                          cuuid: motorTblAdjToRamCharUuid,
                                          permission:   kPermitRead | kPermitNotify | kPermitWrite,
                                          bleService: bleService,
                                          defaultValue: MotorAdjValues())
  
//--------- Motor tbl  Object  used to read back data from VCB RAM to init mottbl view----------------------------

            motorTblRdBack_EntyObj = Entity_motorTbl(name: kEntityMotTblRdBack,
                                          topic: .entyMotTblRdBackTopic,
                                          suuid: motorServiceUuid,
                                          cuuid: motorTblRdBkCharUuid,
                                          permission: kPermitRead,
                                          bleService: bleService,
                                                   defaultValue: MotorValues())
            
//--------- Motor tbl Adjust  Object  used to read back data from VCB RAM to init mottbl Adjust view------------------
            motorTblAdjRdBack_EntyObj = Entity_motorTblAdj(name: kEntityMotTblAdjRdBack,
                                          topic: .entyMotTblAdjRdBackTopic,
                                          suuid: motorServiceUuid,
                                          cuuid: motorTblAdjRdBkCharUuid,
                                          permission: kPermitRead,
                                          bleService: bleService,
                                          defaultValue: MotorAdjValues())

            
//------------------------------------------- vcbConfig  Object ----------------------------
            vcbConfig_EntyObj = Entity_vcbConfig(name: kEntityVcbConfig,
                                                 topic: .entyVcbConfigTopic,
                                                 suuid: vcbConfigServiceUuid,
                                                 cuuid: vcbConfigCharUuid,
                                                 permission: kPermitRead | kPermitNotify,
                                                 bleService: bleService,
                                                 defaultValue: 0)

            vcbLearnMode_EntyObj = Entity_Binary(name: kEntityVcbLearnMode,
                                                    topic: .entyVcbLearnModeTopic,
                                                    suuid: vcbConfigServiceUuid,
                                                    cuuid: vcbLearnModeCharUuid,
                                                    permission: kPermitWrite,
                                                    bleService: bleService,
                                                    defaultValue: false)
            
            
            
//----------------------------------------- Lookup Entity by name --------------------------------------------------
            lookUpByEntity = [kEntityMotTblFlash : .wrMotTblToFlashEntityEnum(motorTblToFlash_EntyObj),
                              kEntityMotTblAdjFlash : .wrMotTblAdjToFlashEntityEnum(motorTblAdjToFlash_EntyObj),
                              kEntityPressureSeneor : .pressSenorEntityEnum(presSeneor_EntyObj),
                              kEntityEncoder : .EncoderEntityEnum(encoder_EntyObj),
                              kEntityTempSeneor : .tempSenorEntityEnum(tempreSen_EntyObj),
                              kEntityMotTblToRam : .motorTblToRamEntityEnum(motorTblToRam_EntyObj),
                              kEntityMotTblAdjToRam : .motorTblAdjToRamEntityEnum(motorTblAdjToRam_EntyObj),
                              kEntityMotTblAdjRdBack : .motorTblAdjRdEntityEnum(motorTblAdjRdBack_EntyObj),
                              kEntityMotTblRdBack : .motorTblRdEntityEnum(motorTblRdBack_EntyObj),
                              kEntityVcbLearnMode : .vcbLearnModeEntityEnum(vcbLearnMode_EntyObj),
                              kEntityVcbConfig : .vcbConfigEntityEnum(vcbConfig_EntyObj)]
            
            
//----------------------------------------- Lookup Entity by Charc UUID ------------------------------------------
            lookUpByCharacUuid =  [motorTblFlashCharUuid : .wrMotTblToFlashEntityEnum(motorTblToFlash_EntyObj),
                                   motorTblAdjFlashCharUuid : .wrMotTblAdjToFlashEntityEnum(motorTblAdjToFlash_EntyObj),
                                   pressureCharUuid : .pressSenorEntityEnum(presSeneor_EntyObj),
                                   tempSenCharUuid : .tempSenorEntityEnum(tempreSen_EntyObj),
                                   encoderCharUuid : .EncoderEntityEnum(encoder_EntyObj),
                                   motorTblToRamCharUuid : .motorTblToRamEntityEnum(motorTblToRam_EntyObj),
                                   motorTblAdjToRamCharUuid : .motorTblAdjToRamEntityEnum(motorTblAdjToRam_EntyObj),
                                   motorTblAdjRdBkCharUuid : .motorTblAdjRdEntityEnum(motorTblAdjRdBack_EntyObj),
                                   motorTblRdBkCharUuid : .motorTblRdEntityEnum(motorTblRdBack_EntyObj),
                                   vcbLearnModeCharUuid : .vcbLearnModeEntityEnum(vcbLearnMode_EntyObj),
                                   vcbConfigCharUuid : .vcbConfigEntityEnum(vcbConfig_EntyObj)]
            
           
            
//----------------------------------------- Build Subcriptions-----------------------------------------
            setupSubscriptions()
            
}// end init
        

 
   
        
        
        
//----------------------------------------- Private functions-----------------------------------------
         
// MARK: - Private functions
        
        private func setupSubscriptions() {
 
// MARK: -  >----------------------- subquibe to  bleStatus ----------------------------------

            
            nc.addObserver(forName: .bleStatus, object: nil, queue: nil, using: { notification in
                if let payload = notification.object as? BleStatusPayload {
                    self.bleStatus = payload.status
                    os_log( "BleService is %s" , log: Log.model, type: .info, payload.status.description)
                    
                    switch payload.status {
                    case .onLine:
                        self.bleService.attachPeripheral(suuid: self.primaryService, forceScan: false
                                             )
                        
                    case .offLine:
                        break
                        
                    case .ready:
                        //self.redLed.get()
                        // self.encoderObj.get()
                        // self.pressureSeneor.get()
                        //  self.tempreSenObj.get()
                        // self.leftButton.setNotify(state: true)
                        
                       //self.vcbConfig_EntyObj.setNotify(state: true)
                        
                        
                      ///  self.motorPerameter_EntyObj.get()
                       //  self.getRssi()
                        // self.bleService.readRssi()
                        break
                        
                    case .connected:
                        break
                        
                    case .disconnected:
                        break
                    }
                    
                }
                
            } )
            
            
// MARK: -  >----------------------- subquibe to  Write confirm ----------------------------------

            nc.addObserver(forName: .characWriteConfirm, object: nil, queue: nil, using: { notification in
                if let payload = notification.object as? CharacWriteConfirmPayload,
                   let thisEntity = self.lookUpByCharacUuid[payload.charac] {
                    switch thisEntity {
                    case .wrMotTblToFlashEntityEnum(var bin):
                        bin.writeConfirm()
                    case .wrMotTblAdjToFlashEntityEnum(var TblAdjToFlash):
                        TblAdjToFlash.writeConfirm()
                        
                                                
                     case .motorTblToRamEntityEnum(let motTblToRam):
                        print(motTblToRam.value)
                        motTblToRam.publish()
                        
                    case .motorTblAdjToRamEntityEnum(let motTblAdjToRam):
                       print(motTblAdjToRam.value)
                       motTblAdjToRam.publish()
                    case .vcbLearnModeEntityEnum(var learn):
                        //learn.publish()
                        print("charc uuid = \(payload.charac)")
                        learn.writeConfirm()
                        
                    default:
                        print("characWriteConfirm default")
                        
                    }
                }
                
            })
            
// MARK: -  >----------------------- subquibe to characNotifyStateChanged ----------------------------------

            // Charac notification state
            nc.addObserver(forName: .characNotifyStateChanged,
                           object: nil,
                           queue: nil,
                           using: { notification in
                if let payload = notification.object as? CharacNotifyStateChangedPayload,
                   let thisEntity = self.lookUpByCharacUuid[payload.charac] {
                    switch thisEntity {
                    case .wrMotTblToFlashEntityEnum(var TblToFlash):
                        TblToFlash.notifyStateChanged(state: payload.state)
                        
                    case .wrMotTblAdjToFlashEntityEnum(var TblAdjToFlash):
                        TblAdjToFlash.notifyStateChanged(state: payload.state)
                        
                    case .tempSenorEntityEnum(var tmp):
                        tmp.notifyStateChanged(state: payload.state)
                        
                    case  .EncoderEntityEnum(var encode):
                        encode.notifyStateChanged(state: payload.state)
                        
                    case .pressSenorEntityEnum(var presenor):
                        presenor.notifyStateChanged(state: payload.state)
                        
                    case .motorTblToRamEntityEnum(var mot):
                        mot.notifyStateChanged(state: payload.state)
                        
                    case .motorTblAdjToRamEntityEnum(var motAdj):
                        motAdj.notifyStateChanged(state: payload.state)
                        
                    case .vcbConfigEntityEnum(var vcbcfg):
                        print("didUpdateNotificationStateFor \(payload.state)")
                        vcbcfg.notifyStateChanged(state: payload.state)
                        
                    default:
                        print("hit characNotifyStateChanged default")
                   
                        
                    }
                }
            })
            
            
            
// MARK: -  >----------------------- subquibe to change in charc value----------------------------------
            
            nc.addObserver(forName: .characValueChanged,
                           object: nil,
                           queue: nil,
                           using: { notification in
                if let payload = notification.object as? CharacValueChangedPayload,
                   let thisEntity = self.lookUpByCharacUuid[payload.charUuid] {
                    switch thisEntity {
                    case .wrMotTblToFlashEntityEnum(let MotTblToFlash):
                        MotTblToFlash.valueChanged(data: payload.data)
                        
                    case .wrMotTblAdjToFlashEntityEnum(let MotTblAdjToFlash):
                        MotTblAdjToFlash.valueChanged(data: payload.data)
                        
                    case .tempSenorEntityEnum(let tmp):
                        
                        tmp.valueChanged(data: payload.data)
                        
                    case  .EncoderEntityEnum(let encode):
                        encode.valueChanged(data: payload.data)
                        
                    case .pressSenorEntityEnum(let presenor):
                        presenor.valueChanged(data: payload.data)
                        
                    case .motorTblToRamEntityEnum(let motor):
                        motor.valueChanged(data: payload.data)
                        
                    case .motorTblAdjToRamEntityEnum(let motorAdj):
                        motorAdj.valueChanged(data: payload.data)

                    case .motorTblAdjRdEntityEnum(let motAdjrdbk):
                        motAdjrdbk.valueChanged(data: payload.data)
 
                    case .motorTblRdEntityEnum(let motorrdbk):
                        motorrdbk.valueChanged(data: payload.data)
                        
                    case .vcbConfigEntityEnum(let vcb):
                        vcb.valueChanged(data: payload.data)
                    default:
                        print("characValueChanged default")
                    }
                }
            })
  
            
            
// MARK: -  >----------------------- subquibe to RSSI value changed ----------------------------------

            
            // RSSI value changed
            nc.addObserver(forName: .rssiValueChanged,
                           object: nil,
                           queue: nil,
                           using: { notification in
                if let payload = notification.object as? RssiValueChangedPayload {
                    os_log("RSSI: %d", log: Log.model, type: .info, payload.value)     // Temporary for debugging
                    nc.post(name: .entyRSSITopic, object: IntegerPayload(value: payload.value,
                                                                         isNotifying: false,
                                                                         didWrite: false))
                }
            })
            
            
            
            
        }
        
        
        
        // MARK: - Public (Internal) API
        //
        func get(entity: String) {
            guard let thisEntity = lookUpByEntity[entity], bleStatus == .ready else { return }
            
            switch thisEntity {
            case .wrMotTblToFlashEntityEnum(let TblToFlash):
                TblToFlash.get()
            case .wrMotTblAdjToFlashEntityEnum(let TblAdjToFlash):
                TblAdjToFlash.get()
                
            case .tempSenorEntityEnum(let temp):
                print(temp.cuuid)
                temp.get()
                
            case  .EncoderEntityEnum(let encode):
                print(encode)
                encode.get()
                
            case .pressSenorEntityEnum(let presenor):
                print(presenor.cuuid)
                presenor.get()
                
             // read motor table back to MotorViewController
            case  .motorTblRdEntityEnum(let motTblRd):
                   motTblRd.get()
                // read motor table back to MotorViewController
               case  .motorTblAdjRdEntityEnum(let motTblAdjRd):
                      motTblAdjRd.get()

                
            default:
                print("hit default")
        
                
            }
            
        }
        
        
        
        func set(entity: String, value: Any, response: Bool) {
            
            guard let thisEntity = lookUpByEntity[entity], bleStatus == .ready else { return }
            
            switch thisEntity {
                // Write motor tbl in VCB Flash
            case .wrMotTblToFlashEntityEnum(let wrToFlash):
                guard let booVal = value as? Bool else {return}
                wrToFlash.set(value: booVal, response: response)
                
                // Write motor tbl Adj in VCB Flash
            case .wrMotTblAdjToFlashEntityEnum(let wrAdjToFlash):
                guard let booVal = value as? Bool else {return}
                wrAdjToFlash.set(value: booVal, response: response)
            
            // Write motor tbl in VCB RAM
            case .motorTblToRamEntityEnum(let wrMotToVcbRam):
                guard let motVal = value as? MotorValues else {return}
                wrMotToVcbRam.set(value: motVal, response: response)
                            
                // Write motorAdj tbl in VCB RAM
            case .motorTblAdjToRamEntityEnum(let motAdjEntity):
                guard let motAdjVal = value as? MotorAdjValues else {return}
                motAdjEntity.set(value: motAdjVal, response: response)
   
            case .vcbLearnModeEntityEnum(let learn):
                guard let learnValVal = value as? Bool else {return}
                learn.set(value: learnValVal, response: response)

                              //
                
            default:
                print("default for model set func")
                
            }
        }
        
  
        
        
        
        
        
        func setNotify(entity: String, state: Bool) {
            
            guard let thisEntity = lookUpByEntity[entity], bleStatus == .ready else { return }
            
            switch thisEntity {
            case .wrMotTblToFlashEntityEnum(let TblToFlash):
                TblToFlash.setNotify(state: state)
                
            case .wrMotTblAdjToFlashEntityEnum(let TblAdjToFlash):
                TblAdjToFlash.setNotify(state: state)
                
            case .tempSenorEntityEnum(let temp):
                temp.setNotify(state: state)
                
            case  .EncoderEntityEnum(let encode):
                encode.setNotify(state: state)
                
            case .pressSenorEntityEnum(let presenor):
                presenor.setNotify(state: state)
                
            case .vcbConfigEntityEnum(let vcbcfg):
                vcbcfg.setNotify(state: state)
                
                
            default:
                print("hit default")
                
            }
        }
        
        func getRssi() {
            // Make a direct call to BleService
            bleService.readRssi()
        }
        
    }




/*
 private func luxConvert(value : Data) -> Double {
 let rawData = dataToUnsignedBytes16(value: value)
 var e :UInt16 = 0
 var m :UInt16 = 0
 
 m = rawData[0] & 0x0FFF;
 e = (rawData[0] & 0xF000) >> 12;
 
 /** e on 4 bits stored in a 16 bit unsigned => it can store 2 << (e - 1) with e < 16 */
 e = (e == 0) ? 1 : 2 << (e - 1);
 
 return Double(m) * (0.01 * Double(e));
 }
 */
/*
 guard let result = data.to(type: UInt16.self)
 else {
 os_log("ERROR: converting data", log: Log.model, type: .error)
 return
 }
 */

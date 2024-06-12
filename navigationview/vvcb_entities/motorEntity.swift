//
//  motorEntity.swift
//  vcb_client
//
//  Created by Billy Cole on 1/16/23.
//

import Foundation
import CoreBluetooth
import os


extension Data {
    var unit32: UInt32 {
           get {
               let i32array = self.withUnsafeBytes { $0.load(as: UInt32.self) }
               return i32array
           }
       }
}
//import cMotorStruct



/*
 class Entity_motorPositon: readOnlySenorEntity {
     
     typealias T = Int32
     var val: Int32 = 0
    
     let Comcuuid: CBUUID = motorStatisCharUuid
    // override cuuid2 = motorStatisCharUuid
   
     
    private func convertToSpeed(bleValue: UInt16) -> UInt16{
        bleValue * 2
    }
    
    override func valueChanged(data: Data) {
        
        let  result2 = dataToUnsignedBytes16(value : data)
        
    
        
        print("this is my data\(result2)")
        bleValue = result2[0]
        
        self.value = convertToSpeed(bleValue: result2[0])
        
        self.isNotifying = false      // let value = SenorPayload(value: result, isNotifying: false)
        publish()
        
    }
    
    override func publish() {
         nc.post(name: topic, object: SenorPayload(value:  self.value, isNotifying: self.isNotifying))
    }
     
     
 func set(value: T, response: Bool) {
         guard (permission & kPermitWrite) == kPermitWrite else { return }
         val = value
      //   bleValue  = value
         bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &val, { Data($0) } ), response: response )
         
         if response == false {
             publish()
         }
     }
     

} //end class Entity_encoder
*/



class Entity_motorTbl: P_Entity {
   
    typealias T = MotorValues
    typealias U = MotorValues
    
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
    
    init(name: String, topic: Notification.Name, suuid: CBUUID, cuuid: CBUUID, permission: UInt8, bleService: BleService,  defaultValue: MotorValues ) {
        self.name = name
        self.topic = topic
        self.bleService = bleService
        self.suuid = suuid
        self.cuuid = cuuid
        self.permission = permission
        self.value = defaultValue
        self.bleValue = defaultValue
    }
    
    
    
    func set(value: T, response: Bool) {
        guard (permission & kPermitWrite) == kPermitWrite else { return }
        
        bleValue = value
        print(bleValue)
        print(cuuid)
        bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes(of: &bleValue) {Data($0)}, response: response )
        
      //  bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &bleValue, { Data($0) } ), response: response )
        
    }
        
        

    func valueChanged(data: Data) {
        
        var value =  MotorValues()
        let _ = withUnsafeMutableBytes(of: &value,{ data.copyBytes(to: $0)} )
        //assert(bytesCopied == MemoryLayout.size(ofValue: value))
        print("motor vals read back\(value) ")
        print("topic \(topic) ")
       // motorPerametersPayload.v
        nc.post(name: topic, object: motorPayload(value: value, isNotifying: self.isNotifying ))
    }
   
    

    func publish() {
        nc.post(name: topic, object: motorPayload(value: self.value, isNotifying: self.isNotifying ))
    }
} // end class pistonInfo



class Entity_motorTblAdj: P_Entity {

   
    typealias T = MotorAdjValues
    typealias U = MotorAdjValues
    
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
    
    init(name: String, topic: Notification.Name, suuid: CBUUID, cuuid: CBUUID, permission: UInt8, bleService: BleService,  defaultValue: MotorAdjValues ) {
        self.name = name
        self.topic = topic
        self.bleService = bleService
        self.suuid = suuid
        self.cuuid = cuuid
        self.permission = permission
        self.value = defaultValue
        self.bleValue = defaultValue
    }
    
    
    
    func set(value: T, response: Bool) {
        guard (permission & kPermitWrite) == kPermitWrite else { return }
        
        bleValue = value
        print(bleValue)
        bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes(of: &bleValue) {Data($0)}, response: response )
        
      //  bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &bleValue, { Data($0) } ), response: response )
        
    }
        
        

    func valueChanged(data: Data) {
        
        var value =  MotorAdjValues()
        let _ = withUnsafeMutableBytes(of: &value,{ data.copyBytes(to: $0)} )
        //assert(bytesCopied == MemoryLayout.size(ofValue: value))
        print("motor adjust \(value) ")
        print("topic \(topic) ")
       // motorPerametersPayload.v
        nc.post(name: topic, object: motorAdjPayload(value: value, isNotifying: self.isNotifying ))
    }
   
    
    //entyMotTblAdjRdBackTopic
    func publish() {
        nc.post(name: topic, object: motorAdjPayload(value: self.value, isNotifying: self.isNotifying ))
    }
}  // end class Entity_motorAdjust




class Entity_pistonInfo: P_Entity {
   
    
    typealias T = [UInt8]
    typealias U = [UInt8]
    
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
    var bleValue: U
    
    init(name: String, topic: Notification.Name, suuid: CBUUID, cuuid: CBUUID, permission: UInt8, bleService: BleService,  defaultValue: T) {
        self.name = name
        self.topic = topic
        self.bleService = bleService
        self.suuid = suuid
        self.cuuid = cuuid
        self.permission = permission
        self.value = defaultValue
        self.bleValue = defaultValue
    }
    
    
    func set(value: T, response: Bool) {
        guard (permission & kPermitWrite) == kPermitWrite else { return }
        
        bleValue[0]  = value[0]
        bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &bleValue, { Data($0) } ), response: response )
        
    }
        
        

    func valueChanged(data: Data) {
        
    }
    

    func publish() {
        nc.post(name: topic, object: PistonPayload(value:  self.value))
    }
} // end class pistonInfo



class Entity_carSpeed: P_Entity {
   
    
    typealias T = [UInt16]
    typealias U = [UInt16]
    
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
    var bleValue: U
    
    init(name: String, topic: Notification.Name, suuid: CBUUID, cuuid: CBUUID, permission: UInt8, bleService: BleService,  defaultValue: T) {
        self.name = name
        self.topic = topic
        self.bleService = bleService
        self.suuid = suuid
        self.cuuid = cuuid
        self.permission = permission
        self.value = defaultValue
        self.bleValue = defaultValue
    }
    
    
    func set(value: T, response: Bool) {
        guard (permission & kPermitWrite) == kPermitWrite else { return }
        
        bleValue  = value
        bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &bleValue, { Data($0) } ), response: response )
        
    }
        
        

    func valueChanged(data: Data) {
        
    }
    
    func publish() {
        nc.post(name: topic, object: carSpeedPayload(value:  self.value))
    }
    
    
} // end class Entity_carSpeed



class Entity_motorRate: P_Entity {
    
    
    typealias T = [UInt32]
    typealias U = [UInt32]
     
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
    var bleValue: U
    
    init(name: String, topic: Notification.Name, suuid: CBUUID, cuuid: CBUUID, permission: UInt8, bleService: BleService,  defaultValue: T) {
        self.name = name
        self.topic = topic
        self.bleService = bleService
        self.suuid = suuid
        self.cuuid = cuuid
        self.permission = permission
        self.value = defaultValue
        self.bleValue = defaultValue
    }
    
    
    func set(value: T, response: Bool) {
        guard (permission & kPermitWrite) == kPermitWrite else { return }
        
        bleValue  = value
        bleService.write(suuid: suuid, cuuid: cuuid, data: withUnsafeBytes( of: &bleValue, { Data($0) } ), response: response )
        
    }
        
        

    func valueChanged(data: Data) {
        
    }
    
    func publish() {
        nc.post(name: topic, object: motorRatePayload(value:  self.value))
    }
    
    
    
}  //end Entity_motorRate




/*
 
private func convertToSpeed(bleValue: UInt16) -> UInt16{
    bleValue * 2
}

 func valueChanged(data: Data) {
    
    let  result2 = dataToUnsignedBytes16(value : data)
    

    
    print("this is my data\(result2)")
    bleValue = result2[0]
    
    self.value = convertToSpeed(bleValue: result2[0])
    
    self.isNotifying = false      // let value = SenorPayload(value: result, isNotifying: false)
    publish()
    
}

 

 
 
 */

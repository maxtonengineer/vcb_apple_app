//
//  motorValues.swift
//  vcb_client
//
//  Created by Billy Cole on 1/25/23.
//

import Foundation


struct MotorValues {
    
    
   // var type:UInt8 = 1
    var pistonCount:UInt8 = 0
    var pistonSize:UInt8 = 0
    
    var speedUL:UInt16 = 0     //
    var speedDL:UInt16 = 0
    var speedDHS:UInt16 = 0
   
    //Phase Positions
    var PhasePosUHS:Int32    = 0
    var PhasePosUL:  Int32   = 0
    var PhasePosParkBP:Int32 = 0
    var PhasePosDHS:Int32    = 0
    var PhasePosDL:Int32     = 0
    var PhasePosParkDC:Int32 = 0
   
    //Phase Speeds
    var PhaseSpeedUA:UInt32 = 0
    var PhaseSpeedUT:UInt32 = 0
    var PhaseSpeedUS:UInt32 = 0
    var PhaseSpeedDA:UInt32 = 0
    var PhaseSpeedDT:UInt32 = 0
    var PhaseSpeedDS:UInt32 = 0
    
    
} // end struct MotorValues


struct MotorAdjValues {
    
    var UHS_delta:Int32 = 0
    var UL_delta :Int32 = 0
    var ParkBP_delta:Int32 = 0
    
    var DHS_delta:Int32 = 0
    var DL_delta:Int32 = 0
    var ParkDC_delta:Int32 = 0
    
       
    //Phase Speeds
    var UA_delta:UInt32 = 0
    var UT_delta:UInt32 = 0
    var US_delta:UInt32 = 0
    
    var DA_delta:UInt32 = 0
    var DT_delta:UInt32 = 0
    var DS_delta:UInt32 = 0
    
    var TempreureOffet:Int32 = 0
    
} // end struct MotorAdjValues





//let x = MemoryLayout<data>.size
//print(data)

//let value = mystruct()
//let data  = withUnsafeBytes(of: value) { Data($0) }

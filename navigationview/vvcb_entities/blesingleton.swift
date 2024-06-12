//
//  blesingleton.swift
//  navigationview
//
//  Created by Billy Cole on 5/30/24.
//

import Foundation
import SwiftUI
import CoreBluetooth


final class SharedObject {
    
    
    static let shared = SharedObject()
    private init() {}
    
    var singleBle = BleService()
}


final class SharedmAdjObject {
    
    
    static let shared = SharedmAdjObject()
    private init() {}
    
    var singlemAdj = MotorAdjValues()
}


final class SharedMotorValues {
        
    static let shared = SharedMotorValues()
    let singleMotorVal: MotorValues
    private init() {   singleMotorVal = MotorValues()   }
    
    
}






final class SharedModObject {
    
    
    static let shared = SharedModObject()
    public var singleMod:Model
    private init() {singleMod =  Model(mAdj: SharedmAdjObject.shared.singlemAdj, mpar:      SharedMotorValues.shared.singleMotorVal,
                             bleService: SharedObject.shared.singleBle)}
    }




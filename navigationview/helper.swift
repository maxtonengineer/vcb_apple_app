//
//  helper.swift
//  vcb_client
//
//  Created by Billy Cole on 12/21/22.
//

import Foundation
import UIKit
import CoreBluetooth
import os
import os.log

class utility {
    
    func floatValue(data: Data) -> Float {
        
        return Float(bitPattern: UInt32(littleEndian: data.withUnsafeBytes { $0.load(as: UInt32.self) }))
    }

}





/*
 func set(value: Bool, response: Bool) {
     let bytes: [UInt8] =  [0x44, 0xFA, 0x00, 0x00]
     let data = Data(bytes: bytes, count: 4)

     print(data) // <44fa0000>
     let f = convert.floatValue(data: data)
     print(f) // 2000.0
 }
 */

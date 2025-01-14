//
//  Data.swift
//  IOTCourse
//
//  Created by Andrew Coad on 20/08/2019.
//  Copyright © 2019 Andrew Coad. All rights reserved.
//

import Foundation

//
// Generic extensions for getting/setting Data
//
extension Data {
    
    init<T>(from value: T) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }
    
    
    
    // Exsample call - results = data.to(type: UInt8.self)
    func to<T>(type: T.Type) -> T? where T: ExpressibleByIntegerLiteral {
        var value: T = 0
        guard count >= MemoryLayout.size(ofValue: value) else { return nil }
        _ = Swift.withUnsafeMutableBytes(of: &value, { copyBytes(to: $0)} )
        return value
    }
}

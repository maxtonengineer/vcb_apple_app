//
//  myAppDelegate.swift
//  navigationview
//
//  Created by Billy Cole on 6/25/24.
//

import Foundation

import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
    
    var bleService: BleService?
    var model: Model?
    var mpar: MotorValues?
    var mAdj: MotorAdjValues?
 
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //print("Your code here")
        
        let bls = BleService()
        bleService = bls
        
        let MotAdjVal =  MotorAdjValues()
        mAdj = MotAdjVal
        
        let Mpar =  MotorValues()
        mpar = Mpar
        model = Model(mAdj:MotAdjVal, mpar: Mpar, bleService: bls)
        
        // Model(bleService: bls)

        
        
        return true
    }
}





///////////////////////////////////////////////////////////////////////////////////////////////


struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}



extension View {

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}

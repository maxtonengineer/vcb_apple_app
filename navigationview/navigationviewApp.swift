//
//  navigationviewApp.swift
//  navigationview
//
//  Created by Billy Cole on 5/26/24.
//

import SwiftUI
import UIKit
import CoreBluetooth


@main
  struct navigationviewApp: App {
      
      
     // @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
          
            //VCBRootView()
            homeScreenView()
           // learnmodeView2()
            //learnScreensetup()
            //learnmodetextfield()
          //  slider2()
                .onAppear{
                    print("top")
                   // Relief_Mode().setupSubscriptions() 
                }
            
            
        }
    }
}


/*
let MotAdjVal =  MotorAdjValues()
//    mAdj = MotAdjVal

let Mpar =  MotorValues()
//   mpar = Mpar
// model = Model(mAdj:MotAdjVal, mpar: Mpar, bleService: bls)

let bls = BleService()
 var bleService = bls

var bleService: BleService?
var model: Model?
var mpar: MotorValues?
var mAdj: MotorAdjValues?
*/
/*
     internal let bleService: BleService?
          var model: Model?
      var mpar: MotorValues?
      var mAdj: MotorAdjValues?
      

      init(){
          
       

           let bls = SharedObject.shared.singleBle
            bleService = bls
          
          
          
          let MotAdjVal =  SharedmAdjObject.shared.singlemAdj
               mAdj = MotAdjVal
          
          let Mpar =  SharedMotorValues.shared.singleMotorVal
               mpar = Mpar
          
           let  Model = Model(mAdj:MotAdjVal, mpar: Mpar, bleService: bls)
                model = Model
          /**/
 
    }
       */

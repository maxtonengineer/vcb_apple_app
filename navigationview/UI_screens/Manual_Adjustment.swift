//
//  Manual_Adjustment.swift
//  navigationview
//
//  Created by Billy Cole on 5/31/24.
//

import SwiftUI
import Foundation
import os
import os.log
import CoreBluetooth

struct Manual_Adjustment: View {
    // MARK: - Properties
    @State var backgroundColor: Color = Color.white
    var ble = SharedObject.shared.singleBle
    var image_connect3 = maxtonSetupBar()
    @Environment(\.dismiss) private var dismiss
    
    @State  var ConnectStatus: String = "No Connect"
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white
    
    
    
    
    var body: some View {
        
        
        ZStack{
            
            backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("Manual Adj")
            image_connect3
                .padding(.bottom, 15)
                .navigationBarHidden(true)
            
            Button {
                dismiss()
            } label: {
                Text("go home")
                    .font(.largeTitle)
            }
            .padding(.top, 900.0)
            
            //ScrollView{
            // Text("Manual Adjustment")
            // }//end scrollview
            
            
        }// end zstack
        
        
    }
    
    // MARK: - Private Methods
    func foo(){
        
        SharedObject.shared.singleBle.attachPeripheral(suuid: motorServiceUuid)
    }
    
    
    private func setupSubscriptions() {
        
        //// this is for the ble bus connection status
        nc.addObserver(forName: .connectStatus,
                       object: nil,
                       queue: OperationQueue.main,
                       using: { notification in
            if let payload = notification.object as? BleStatusPayload {
                
                if payload.status == BleStatus.connected {
                    self.ConnectStatus = "connected"
                    //   self.BusStatus.text = " connected"
                    //   self.BusStatus.backgroundColor = .green
                    self.backgroundColor = .green
                    // print("i am connected") //<-----------------temp debug----------
                } else if payload.status == BleStatus.disconnected {
                    self.ConnectStatus = "disconnected"
                    //  self.BusStatus.text = "disconnected"
                    //  self.BusStatus.backgroundColor = .gray
                    self.backgroundColor = .gray
                    //  print("i am disconnected") //<-----------------temp debug----------
                    
                }
                // print("this is my \(payload.value)")
                //self.RSSI = String(payload.status)
            }
            
        })
        
        
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        nc.addObserver(forName: .entyVcbConfigTopic,
                       object: nil,
                       queue: OperationQueue.main,
                       using: { notification in
            if let payload = notification.object as? vcbConfigPayload {
                
                
                switch payload.value{
                    
                case 0:
                    print("vcbstate  \(payload.value)")
                    self.bkcolU = .clear
                    self.bkcolUL = .clear
                    self.bkcolD = .clear
                    self.bkcolDL = .clear
                    
                    
                case 1:
                    print("vcbstate  \(payload.value)")
                    self.bkcolU = .red
                    self.bkcolUL = .clear
                    self.bkcolD = .clear
                    self.bkcolDL = .clear
                    
                case 2:
                    print("vcbstate  \(payload.value)")
                    self.bkcolU = .clear
                    self.bkcolUL = .red
                    self.bkcolD = .clear
                    self.bkcolDL = .clear
                    
                    
                case 3:
                    print("vcbstate  \(payload.value)")
                    self.bkcolU = .clear
                    self.bkcolUL = .clear
                    self.bkcolD = .red
                    self.bkcolDL = .clear
                    
                    
                case 4:
                    print("vcbstate  \(payload.value)")
                    self.bkcolU = .clear
                    self.bkcolUL = .clear
                    self.bkcolD = .clear
                    self.bkcolDL = .red
                    
                    
                default:
                    print("vcbstate default \(payload.value)")
                    self.bkcolU = .clear
                    self.bkcolUL = .clear
                    self.bkcolD = .clear
                    self.bkcolDL = .clear
                }
                
            }
            
        })  //END entyEncoderTopic
        
        
        
    }
} // end struct Manual_Adjustment
    
    struct Manual_Adjustment_Previews: PreviewProvider {
        static var previews: some View {
            Manual_Adjustment()
        }
    }
    


//
//  Relief Mode.swift
//  navigationview
//
//  Created by Billy Cole on 5/31/24.
//

import SwiftUI
import Foundation
import os
import os.log
import CoreBluetooth

struct Relief_Mode: View {
    
// MARK: - Properties
    @State var backgroundColor: Color = Color.white
    var image_connect3 = maxtonSetupBar()
    var ble = SharedObject.shared.singleBle
    
    @State private var connectStatus: String = "No Connect"
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white

    
    
    
    
    
    
    @Environment(\.dismiss) private var dismiss
 
// MARK: - Computed Properties
    var body: some View {
        
        
        ZStack{
            
            
            backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("Learn Mode")
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            VStack(alignment: .center, spacing: 30){
                
                
                Text("Maxton")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                
                
                
                Text("Setup Mode")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                
////////////////////////////////////////////////////////////////////////////////////////////////

 
                
                HStack(spacing: 30){
                    
                    Text("U")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(bkcolU)
                    //Text("U").background(Color.red)
                    
                    Text("UL")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(bkcolUL)
                    
                    //.foregroundColor(.black)
                    Text("D")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(bkcolD)
                    
                    
                    Text("DL")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(bkcolDL)
                    
                    
                }//end  HStack(spacing: 30)

                
                
                
                
                
                
                
                HStack(spacing: 30){
                    
                    ZStack{
                        
                        Rectangle()
                            .fill(Color.cyan)
                            .frame(width:130, height: 70, alignment: .leading)
                        
                        Image(systemName: "gamecontroller.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                    }
                    
                    
                    
                    Text(connectStatus)
                        .font(.title)
                        .frame(width:160,height:60,alignment: .center)
                        .background(Color.white)
                    
                }//end HStack(spacing: 30)
                
            }
            
            
             ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            .padding(.bottom, 800)
            .navigationBarHidden(true)
            
            Button {
                dismiss()
            } label: {
                Text("go home")
                    .font(.largeTitle)
            }
            .padding(.top, 900.0)
            
            
            
        }// end zstack
    }
    
    init() {
         
     }
    
    // MARK: - Private Methods
/*    func foo(){
       
        bleService.attachPeripheral(suuid: motorServiceUuid)
        
        modelRef.get(entity: "t")
    }
  */
   
     func setupSubscriptions() {
        print("setupSubscriptions")
        
         nc.addObserver(forName:.entyVcbLearnModeTopic , object: nil, queue: OperationQueue.main, using: { notification in
         if let payload = notification.object as? BinaryPayload {
         
             print("hi \(payload.value)")
         }
         })
         
         
         
         
         
         
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


         
        /* */
    }
    
        
    
}// end Relief_Mode



struct Relief_Mode_Previews: PreviewProvider {
    static var previews: some View {
        Relief_Mode()
    }
}

/*
 ScrollView{
     Text("did it work")
     
         .onAppear{
             self.setupSubscriptions()
         }
     /**/
     
 }//end scrollview

 */

//
//  learnMode.swift
//  navigationview
//
//  Created by Billy Cole on 5/26/24.
//

import SwiftUI
import Foundation
import os
import os.log
import CoreBluetooth

struct LearnMode: View  {
    
    // MARK: - Properties
    //  @State var viewDidLoad2 = false
    
    
    
    let LmodelObj: Model = modelObj //SharedModObject.shared.singleMod
    
    @State var backgroundColor: Color = Color.white
    @State var tile: String = "yes"
    @State var lb1: String = "Description"
    @State var lb2: String = "yes"
    @State var ble1: String = "ble"
    @State  var connectStatus: String = "No Connect"
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white
    @State var startBtn: Color = Color.green
    @State var startBtnFrame: Color = Color.green
    @State var  isSelected: Bool = false
    @State var motList = DecscriptionView()
    @State var LmotorPeramInp = learnScreensetup()
    @State var Llearnmodetextfield = learnmodetextfield()
    @State var LInstructionsView = InstructionsView()
    //  let LbleService: BleService = bleService
    
    @Environment(\.dismiss) private var dismiss
    //var Maxton_SetupBar = maxtonSetupBar()
    
    // @State var u_backgroundColor = Text("U").background(Color.red)
    //  @State var x:Int32   = 0
    //  var model: Model = SharedModObject.shared.singleMod
    //var ble = navigationviewApp()      //SharedObject.shared.singleBle
    // MARK: - Computed Properties
    var body: some View {
        
        ZStack{
            
            
            backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("Learn Mode")
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
            VStack(alignment: .center, spacing: 30){
                
                
                //   Text("")
                
                
                
                
                
                Text("Maxton")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .padding(.top, -15)
                
                
                
                Text("Setup Mode")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .padding(.top, -20)
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
                .padding(.top, -30.0)
                
                
                Text("Learn Mode")
                    .font(.title)
                    .padding(.top, -30.0)
                
                
                HStack(spacing: 40){
                    
                    
                    Image("")//Image(ble1)
                        .imageScale(.small)
                    
                    
                    Button {
                        self.startBtn = Color.red
                        self.startBtnFrame = Color.red
                        LmodelObj.set(entity: kEntityVcbLearnMode, value: !self.isSelected, response: true)
                        
                        
                    } label: {
                        Text("Start")
                        
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .accessibilityLabel((kEntityVcbLearnMode) )
                            .background(self.startBtn)
                            .disabled(false)
                        
                    }
                    
                    .frame(width: 200, height: 60)
                    .background(startBtnFrame)
                    .padding(-10)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Stop")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                    }
                    .frame(width: 200, height: 60)
                    .background(Color.gray)
                    
                    /*
                     Text(connectStatus)
                     .font(.title)
                     .frame(width:160,height:60,alignment: .center)
                     .background(Color.white)
                     */
                }// END HStack(spacing: 40)
                
                .padding(.top, 30.0)//end HStack(spacing: 30)
                //Text("end vstack")
            }// END  VStack(alignment: .center, spacing: 30)
            
        } //end zstack
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        .padding(.bottom, 750)  //.padding(.bottom, 798)
        .navigationBarHidden(true)
        
  /*
        VStack(spacing: 0) {
            
            //motList
            LmotorPeramInp
                .padding(10)
            Llearnmodetextfield
                .padding(.bottom,10)
            LInstructionsView
            
        }
        .padding(.top, 70)
   */     /*  */
        
        Button {
            dismiss()
        } label: {
            Text("go home")
                .font(.largeTitle)
        }
        .padding(.top, 960.0)
        
        
        
    }// end var body: some View
    

        
  //  }//  struct LearnMode
    

    
    // MARK: - private methods
    
    
    func chk(){
        //  if let bl = ble {
      //  self.LbleService.attachPeripheral(suuid: motorServiceUuid)
        //LmodelObj.get(entity: kEntityTempSeneor)
        LmodelObj.get(entity: kEntityTempSeneor)
        // ble.attachPeripheral(suuid: motorServiceUuid)
        //   }
        
        //       model.get(entity: "hello")
    }
    
    
    private func setupSubscriptions() {
        
        //// this is for the ble bus connection status
        nc.addObserver(forName: .connectStatus,
                       object: nil,
                       queue: OperationQueue.main,
                       using: { notification in
            if let payload = notification.object as? BleStatusPayload {
                
                if payload.status == BleStatus.connected {
                    self.connectStatus = "connected"
                    //   self.BusStatus.text = " connected"
                    //   self.BusStatus.backgroundColor = .green
                    self.backgroundColor = .green
                    // print("i am connected") //<-----------------temp debug----------
                } else if payload.status == BleStatus.disconnected {
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
        
        
        nc.addObserver(forName: .entyVcbLearnModeTopic,
                       object: nil,
                       queue: OperationQueue.main,
                       using: { notification in
            if let payload = notification.object as? BinaryPayload {
                // self.Speed.text = "\(payload.value)"
                self.isSelected = !payload.value
                if( self.isSelected == false){
                    self.startBtn = .green
                    self.startBtnFrame = Color.green
                    
                }
                
                print("entyVcbLearnModeTopic  \(payload.value)")
            }
            
        })  //END entyVcbLearnModeTopic
        
        
        
        
    }// end func setupSubscriptions()
}
    
    struct LearnMode_Previews: PreviewProvider {
        static var previews: some View {
            LearnMode()
        }
        
    } //struct LearnMode: View
    
    
    /*
     Button {
     self.tile = "hi"
     
     } label: {
     Text("Learn Mode")
     .font(.largeTitle)
     
     }
     
     
     
     /*  ZStack{
           
           Rectangle()
               .fill(Color.cyan)
               .frame(width:130, height: 70, alignment: .leading)
           
           Image(systemName: "gamecontroller.fill")
               .font(.system(size: 50))
               .foregroundColor(.red)
       }
      
       
       Toggle(isOn: $v ) {
           Text("hi toggle")
      // isOn: true
       
       }
       
      */
       
      // TextField("wwwee", text: .)
     
     
     .onAppear {
                     print("onAppear learn mode")
                       print(viewDidLoad2)
         
                     if viewDidLoad2 == false {
                         // 3
                         viewDidLoad2 = true
                         // 4
                         // Perform any viewDidLoad logic here.
                         print("viewDidLoad learn mode")
                         print(viewDidLoad2)
                     }
                         print(viewDidLoad2)
                 }


     */


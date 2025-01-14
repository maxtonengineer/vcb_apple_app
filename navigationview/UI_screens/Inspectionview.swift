//
//  Inspectionview.swift
//  navigationview
//
//  Created by Billy Cole on 6/26/24.
//

import SwiftUI








struct Inspectionview: View {
    
    
    
    @State var backgroundColor: Color = Color.white
    @State private var contrSpeed:String = "100 fpm"
   
    var image_connect3 = maxtonSetupBar()
    var ble = navigationviewApp()
    @Environment(\.dismiss) private var dismiss
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white
    @State var startBtnFrame: Color = Color.green
    @State var startBtn: Color = Color.green
    @State var  isSelected: Bool = false
      
    @State var LSensor = SensorView()
    @State var Lcaradj =  InspectioncontrView()
    
    @Environment(\.dismiss) private var ovdismiss
    let LmodelObj: Model = modelObj
    
    let ovLmodelObj: Model = modelObj
    @State private var subScripObj =  SharedSubscriptionManager.shared.singleSubscriptionManager
    
   
    
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .center, spacing: 30){
                  
                Text("Maxton")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .position(x:381,y:35)
                
                
                
                Text("Setup Mode")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    //.padding(.top, -20)
                    .position(x:381,y:-45)
    ////////////////////////////////////////////////////////////////////////////////////////////////

                HStack(alignment: .center, spacing: 30){
                    
                    Text("U")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(subScripObj.bkcolU)
                    //Text("U").background(Color.red)
                    
                    Text("UL")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(subScripObj.bkcolUL)
                    
                    //.foregroundColor(.black)
                    Text("D")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(subScripObj.bkcolD)
                    
                    
                    Text("DL")
                        .font(.title)
                        .frame(width:40,height:40,alignment: .center)
                        .background(subScripObj.bkcolDL)
                    
                } // end HStack(spacing: 30)
                .position(x:380,y:-100)
                //.padding(.top,-0.0)
                  
                Text("Inspection Mode")
                    .font(.title)
                   // .padding(.top, -30.0)
                    .position(x:380,y:-180)
                
                HStack(spacing: 40){
                    
                   // Image("")//Image(ble1)
                     //   .imageScale(.small)
                    
                    
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
                   
                }// end  HStack(spacing: 40)
               //102. .padding(.top, 0.0)//end HStack(spacing: 30)
                .position(x:380,y:-220)
                
                 Lcaradj
                    .position(x:430,y:-180)
                
                LSensor
                    .position(x:380,y:-300)
                
                HStack(spacing: 50){
                    
                    Image(systemName: "triangle.fill")
                        .overlay {
                                      Rectangle()
                                .stroke(Color.gray, lineWidth: 4)
                                          .frame(width: 300,
                                                 height: 40)
                                  }
                        .position(x:400,y:100)
                    Text("speed")
                    Image(systemName: "triangle.fill")
                    
                }
                .position(x:850,y:100)
                .frame(width: 300,height: 100)
                 .position(x:300,y:100)
          
                Button {
                     dismiss()
                 } label: {
                     Text("go home")
                      //   .frame(width: 200,height: 40)
                     .font(.largeTitle)
                     .foregroundColor(.black)
                 }
                 .frame(width: 200,height: 40)
                // .padding(.top, 1700.0)
                 .position(x:610,y:400)
 
            

              }// end outer VStack(alignment: .center, spacing: 30)
            .position(x:385,y:470)
            
            
        }//end ZStack
        .background(Color.white)
    }// end var body: some View
    
    private func setupSubscriptions() {
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

    
    
    
    
    
    
}// end struct Inspectionview: View





struct Inspectionview_Previews: PreviewProvider {
    static var previews: some View {
        Inspectionview()
    }
}

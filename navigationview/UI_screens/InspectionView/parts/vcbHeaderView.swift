//
//  vcbHeaderView.swift
//  navigationview
//
//  Created by Billy Cole on 7/18/24.
//

import SwiftUI

struct vcbHeaderView: View {
    
    
    @State var backgroundColor: Color = Color.white
    @State private var contrSpeed:String = "100 fpm"
    @State  var n :String
    var ble = navigationviewApp()
    @Environment(\.dismiss) private var dismiss
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white
    @State var startBtnFrame: Color = Color.green
    @State var startBtn: Color = Color.green
    @State var  isSelected: Bool = false
   
    @Environment(\.dismiss) private var ovdismiss
    let LmodelObj: Model = modelObj
       

    

    
    
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .center, spacing: 30){
                  
                Text("Maxton")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .padding(.top, 25)
                
                
                
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
                    
                } // end HStack(spacing: 30)
                .padding(.top,-0.0)
                  
                Text(n)
                    .font(.title)
                    .padding(.top, -30.0)
                   // .position(x:0,y:0)
                
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
                .padding(.top, 0.0)//end HStack(spacing: 30)
          
                  
              }// end outer VStack(alignment: .center, spacing: 30)
            .position(x:385,y:114)
            
            
        }//end ZStack
        
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


}












struct vcbHeaderView_Previews: PreviewProvider {
  
    
    static var previews: some View {
        vcbHeaderView(n: "name of mode")
    }
}

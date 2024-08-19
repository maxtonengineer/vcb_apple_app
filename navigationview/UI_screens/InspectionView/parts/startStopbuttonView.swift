//
//  startbuttonView.swift
//  navigationview
//
//  Created by Tim Fan on 8/8/24.
//

import SwiftUI

struct startStopbuttonView: View {
    
    @EnvironmentObject var viewmodel: SubscriptionManager
    let LmodelObj: Model = modelObj
    @State var  isSelected: Bool = false
    
    
    var body: some View {
        
        
        HStack(spacing: 40){
            
      //      Image("ble")
        //        .imageScale(.large)
            
            
            Button {
                viewmodel.conStartBtn = Color.red
                viewmodel.constartBtnFrame = Color.red
                LmodelObj.set(entity: kEntityVcbLearnMode, value: !self.isSelected, response: true)
                
               // accessibilityLabel kEntityVcbLearnMode
            } label: {
                Text("Start")
                 
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .accessibilityLabel((kEntityVcbLearnMode) )
                    .background(viewmodel.conStartBtn )
                    .disabled(false)
                
                
            }
            
            .frame(width: 100, height: 40)
            .background(viewmodel.constartBtnFrame)
            .padding(-10)
            

            Button {
              //  dismiss()
            } label: {
                Text("Stop")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
            .frame(width: 100, height: 40)
            .background(Color.gray)
                          
        }// end  HStack(spacing: 40)
       // .padding(.top, -30.0)//end HStack(spacing: 30)
        .offset(x:0,y:-0)
        //.buttonStyle(.borderedProminent)
    }
}

#Preview {
    startStopbuttonView()
        .environmentObject(SubscriptionManager())
}

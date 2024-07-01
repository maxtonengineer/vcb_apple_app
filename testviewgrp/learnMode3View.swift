//
//  learnMode3View.swift
//  navigationview
//
//  Created by Billy Cole on 6/28/24.
//

import SwiftUI

struct learnMode3View: View {
    
    
    @State var backgroundColor: Color = Color.white
    @State  var connectStatus: String = "No Connect"
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white
    @State var startBtnFrame: Color = Color.green
    @State var startBtn: Color = Color.green
    @State var  isSelected: Bool = false
    @State var LmotorPeramInp = learnScreensetup()
    @State var Llearnmodetextfield = learnmodetextfield()
    @State var LInstructionsView = InstructionsView()
    @Environment(\.dismiss) private var dismiss
    let LmodelObj: Model = modelObj
    
   
    

    var body: some View {
        
        HStack(spacing: 40){
            
            
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
        .padding(.top, -400.0)//end HStack(spacing: 30)

        
        
    }
    
    
    
    
    
}// end struct learnMode3View: View 










struct learnMode3View_Previews: PreviewProvider {
    static var previews: some View {
        learnMode3View()
    }
}

//
//  Manual_Adjustment.swift
//  navigationview
//
//  Created by Billy Cole on 5/31/24.
//

import SwiftUI
import Foundation


struct Manual_Adjustment: View {
// MARK: - Properties
    @State var backgroundColor: Color = Color.white
    var ble = SharedObject.shared.singleBle
    var image_connect3 = c3()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
    
        ZStack{
        
            backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("Manual Adj")
            image_connect3
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
   
}
struct Manual_Adjustment_Previews: PreviewProvider {
    static var previews: some View {
        Manual_Adjustment()
    }
}


//
//  learnMode.swift
//  navigationview
//
//  Created by Billy Cole on 5/26/24.
//

import Foundation
import SwiftUI

struct LearnMode: View  {
    
    // MARK: - Properties
    @State var backgroundColor: Color = Color.white
    @State var tile: String = "yes"
    @Environment(\.dismiss) private var dismiss
    var image_connect3 = c3()
   // @State var u_backgroundColor = Text("U").background(Color.red)
  //  @State var x:Int32   = 0
  //  var model: Model = SharedModObject.shared.singleMod
    //var ble = navigationviewApp()      //SharedObject.shared.singleBle
    var body: some View {
        
        ZStack{
        
           
            backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("Learn Mode")
            
            image_connect3
            .navigationBarHidden(true)
            
            Button {
                dismiss()
            } label: {
                Text("go home")
                    .font(.largeTitle)
            }
            .padding(.top, 900.0)


            
        }// end zstack
        
    }//  var body: some View
    
    
    
// MARK: - private methods
    
    func chk(){
      //  if let bl = ble {
        bleRef.attachPeripheral(suuid: motorServiceUuid)
        
           // ble.attachPeripheral(suuid: motorServiceUuid)
     //   }
      
 //       model.get(entity: "hello")
    }
 
    
    
    
}// end struct LearnMode: View
        

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

 */

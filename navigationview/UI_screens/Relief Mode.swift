//
//  Relief Mode.swift
//  navigationview
//
//  Created by Billy Cole on 5/31/24.
//

import SwiftUI
import Foundation


struct Relief_Mode: View {
    
// MARK: - Properties
    @State var backgroundColor: Color = Color.white
    var image_connect3 = c3()
    var ble = SharedObject.shared.singleBle
    @Environment(\.dismiss) private var dismiss
 
// MARK: - Computed Properties
    var body: some View {
        
        
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("Relief Mode")
            image_connect3
                .navigationBarHidden(true)
           /*
            Button("Dissmiss"){
                dismiss()
            }
            .font(.largeTitle)
            */
            Button {
                dismiss()
            } label: {
                Text("go home")
                    .font(.largeTitle)
            }
            .padding(.top, 900.0)


        }// end zstack
    }
    // MARK: - Private Methods
    init() {
         
     }
    func foo(){
       
        bleRef.attachPeripheral(suuid: motorServiceUuid)
        
        modelRef.get(entity: "t")
    }
    
   
     func setupSubscriptions() {
        print("setupSubscriptions")
        
         nc.addObserver(forName:.entyVcbLearnModeTopic , object: nil, queue: OperationQueue.main, using: { notification in
         if let payload = notification.object as? BinaryPayload {
         
             print("hi \(payload.value)")
         }
         })
         
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

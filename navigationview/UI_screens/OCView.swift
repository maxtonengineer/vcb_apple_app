//
//  OCView.swift
//  navigationview
//
//  Created by Billy Cole on 5/31/24.
//
import SwiftUI
import Foundation
import os
import os.log
import CoreBluetooth

struct OCView: View {
    
// MARK: - Stored Properties
    @State var backgroundColor: Color = Color.white
    var image_connect3 = maxtonSetupBar()
    var ble = navigationviewApp()
    @Environment(\.dismiss) private var dismiss
    @State var bkcolU: Color = Color.white
    @State var bkcolUL: Color = Color.white
    @State var bkcolD: Color = Color.white
    @State var bkcolDL: Color = Color.white

    
    
    
// MARK: - Computed Properties
    var body: some View {
        ZStack{
        
        backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("OCV Mode")
            
      //  image_connect3
                .padding(.bottom, 15)
                .navigationBarHidden(true)
            
            Button {
                dismiss()
            } label: {
                Text("go home")
                    .font(.largeTitle)
            }
            .padding(.top, 800.0)

            
        }// end zstack
        
// MARK: - Private Methods
        
    }//var body: some View
    
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
    
    
    
    
    
}//struct OCView: View

    
    
    
struct OCView_Previews: PreviewProvider {
    static var previews: some View {
        OCView()
    }
}

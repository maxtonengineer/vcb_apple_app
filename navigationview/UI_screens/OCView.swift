//
//  OCView.swift
//  navigationview
//
//  Created by Billy Cole on 5/31/24.
//
import Foundation
import SwiftUI
import CoreBluetooth

struct OCView: View {
    
// MARK: - Stored Properties
    @State var backgroundColor: Color = Color.white
    var image_connect3 = c3()
    var ble = navigationviewApp()
    @Environment(\.dismiss) private var dismiss
    
// MARK: - Computed Properties
    var body: some View {
        ZStack{
        
        backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("OCV Mode")
            
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
        
// MARK: - Private Methods
        
    }//var body: some View
}//struct OCView: View

    
    
    
struct OCView_Previews: PreviewProvider {
    static var previews: some View {
        OCView()
    }
}

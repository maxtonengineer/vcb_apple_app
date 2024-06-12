//
//  performanceView.swift
//  navigationview
//
//  Created by Billy Cole on 5/31/24.
//

import SwiftUI

struct performanceView: View {
    
    // MARK: - Stored Properties
        @State var backgroundColor: Color = Color.white
        var image_connect3 = c3()
        var ble = navigationviewApp()
        @Environment(\.dismiss) private var dismiss
        
    // MARK: - Computed Properties
    
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
                .navigationTitle("Relief Mode")
            image_connect3
                .navigationBarHidden(true)
            
            Button {
                dismiss()
            } label: {
                Text("go home")
                    .font(.largeTitle)
            }
            .padding(.top, 900.0)

            
        }// en
        
        
        
        
        
        
        
        
        
    }
}










struct performanceView_Previews: PreviewProvider {
    static var previews: some View {
        performanceView()
    }
}

//
//  InstructionsView.swift
//  navigationview
//
//  Created by Billy Cole on 6/24/24.
//

import SwiftUI

struct InstructionsView: View {
    
    @State public var Listruction: String = "Place Up Call"
    
    
    var body: some View {
        
        VStack{
            
            
            Text("Instructions")
                .frame(width: 700,height: 30, alignment: .leading)
                .font(.largeTitle)
                .textFieldStyle(.roundedBorder)
                .padding()

        
        
        Divider()
            .frame(width: 700,alignment: .leading)
            .frame(height: 1)
            .overlay(.black)
            .padding()
        
        
        Text(Listruction)
            .frame(width: 700,height: 30, alignment: .leading)
            .font(.largeTitle)
            .textFieldStyle(.roundedBorder)
            .padding()
           
        }
        .padding()
        .frame(width: 750,height: 200,  alignment: .top)
        .background(Color.clear)
        .border(.black, width: 2)

 
    }
}






struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
       InstructionsView()
       // AboutView()
    }
}

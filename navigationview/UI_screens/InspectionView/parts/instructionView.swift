//
//  inspectonview.swift
//  navigationview
//
//  Created by Tim Fan on 7/23/24.
//

import SwiftUI

struct InstructionsView: View {
    
    @State public var Listruction: String = "Place Up Call"
    
    
    var body: some View {
        
        VStack{
            
            
            Text("Instructions")
                .frame(width: 700,height: 30, alignment: .leading)
                .font(.system(size: 25, weight: .bold, design: .default))
                .textFieldStyle(.roundedBorder)
               // .padding()

        
        
        Divider()
            .frame(width: 700,alignment: .leading)
            .frame(height: 1)
            .overlay(.black)
            .padding()
        
        
        Text(Listruction)
            .frame(width: 700,height: 30, alignment: .leading)
            .font(.system(size: 25, weight: .regular, design: .default))
            .textFieldStyle(.roundedBorder)
           // .padding()
           
        } // end VStack
        
        .padding()
        .frame(width: 750,height: 150,  alignment: .center)
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

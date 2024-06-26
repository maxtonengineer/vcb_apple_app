//
//  learnmodetextfield.swift
//  navigationview
//
//  Created by Billy Cole on 6/24/24.
//

import SwiftUI

struct learnmodetextfield: View {

    @FocusState var focus: FormFieldFocus?
    @State var pistonDiameter: String = ""
    @State var contrSpeed: String = ""
    @State var flow: String = ""
    
     var body: some View {


         VStack(spacing: -10) {
             
             
             
             
             
             // MARK: - TextField -  1
             TextField("Flow (GPM)", text: $flow)
              
                 .font(.largeTitle)
                 .textFieldStyle(.roundedBorder)
                 .padding()
                 .onSubmit {
                     print(flow)
                     focus = .eDiameter
                 }
                 .focused($focus, equals: .eFlow)
                // .padding(.bottom, -700)
             
             
             Divider()
                 .frame(width: 700,alignment: .leading)
                 .frame(height: 1)
                 .overlay(.black)
                 .padding()
             
             // MARK: - TextField -  2
             TextField("Piston Diameter", text: $pistonDiameter)
                 .font(.largeTitle)
                 .textFieldStyle(.roundedBorder)
                 .padding()
                 .onSubmit {
                     print(pistonDiameter)
                     focus = .econtrSpeed
                 }
                 .focused($focus, equals: .eDiameter)
             Divider()
                 .frame(width: 700,alignment: .leading)
                 .frame(height: 1)
                 .overlay(.black)
                 .padding()

             
             
             
             // MARK: - TextField -  3
             
             TextField("Contract Speed", text: $contrSpeed)
                 .font(.largeTitle)
                 .textFieldStyle(.roundedBorder)
                 .padding()
                 .onSubmit {
                     print($contrSpeed)
                 }
                 .focused($focus, equals: .econtrSpeed)
           
             
         }// end VStack
         .onAppear {
             focus = .eFlow
         } // end body
         
         
         .frame(width: 750,height: 275,  alignment: .top)
         .background(Color.clear)
         .border(.black, width: 5)
    /*      Rectangle()
             .fill(Color.red)
             .frame(width: 700,height: 500)
    */
            

     }
     
     enum FormFieldFocus: Hashable {
         case eFlow
         case eDiameter
         case econtrSpeed
         
     }
     
    }// end struct DecscriptionView: View























struct learnmodetextfield_Previews: PreviewProvider {
    static var previews: some View {
        learnmodetextfield()
    }
}

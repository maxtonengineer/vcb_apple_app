//
//  SwiftUItestView.swift
//  navigationview
//
//  Created by Billy Cole on 6/26/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            
            
           Image(systemName:"checkmark")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
            
               //   .overlay(alignment: .center) {
                      Circle()
                    Image(systemName:"checkmark")
                        .background(Color.white)
                 // }// end overlay
   
            
          HStack {
              
              
                VStack(alignment: .leading) {
                    Text("Rachael Chiseck")
                        .font(.headline)
                     //Spacer()
                    Text("Chief Executive Officer")
                        .font(.subheadline)
                }
              
                 Spacer()
                
                Text("hi")//   Spacer()
                .background(Color.blue)
            }
            .padding()
            //.background(Color.blue)
            .foregroundColor(.primary)
            .background(Color.primary.colorInvert().opacity(0.75))
            
            Text("what")
                .font(.largeTitle)
                .padding(.all)
  
        /* */
            
            
        }// end ZStack(alignment: .bottom)
        .background(Color.red)
        
    }// end var body: some View
    
}// end struct ProfileView: View



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

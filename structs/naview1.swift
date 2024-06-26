//
//  naview1.swift
//  navigationview
//
//  Created by Billy Cole on 6/11/24.
//

import Foundation
import SwiftUI

struct mainav: View {
    @State var startBtn2: Color = Color.green
    @State var startBtnFrame2: Color = Color.green
    var body: some View {
        
        Text("hi")
        
        
           Button {
               self.startBtn2 = Color.red
               self.startBtnFrame2 = Color.red
              // Lmodel.set(entity: kEntityVcbLearnMode, value: true, response: true)
                   
               
            } label: {
               Text("Start")
                
                   .foregroundColor(.black)
                   .font(.largeTitle)
                   .accessibilityLabel((kEntityVcbLearnMode) )
                   .background(self.startBtn2)
                   .disabled(false)
               
           }

        
        
        
        
        
        
        
        
 /*
        
        NavigationView {
              ScrollView {
                  
                  
                  
                  NavigationLink("Manual Adjustment", destination: Manual_Adjustment())
                      .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                  
              /*
                  Text("hi")
                   .font(.largeTitle)
                   .foregroundColor(.black)
   
                  Text("hi")
                   .font(.largeTitle)
                   .foregroundColor(.black)
                  
                  Text("hi")
                   .font(.largeTitle)
                   .foregroundColor(.black)
                 */
                
                
           } // end scrollView
             // .padding(.top, 400.0)
            
              .navigationTitle("Home")
             // .navigationBarTitleDisplayMode(.automatic)
              .navigationBarHidden(true)
        }
       // .padding(.top, 300.0)// end  NavigationView
        
     */
        
    }// end var body: some View
    
    
}//end struct mainav: View

struct mainav_Previews: PreviewProvider {
    static var previews: some View {
        mainav()
    }
}

//
//  mainMenuView.swift
//  navigationview
//
//  Created by Billy Cole on 6/28/24.
//

import SwiftUI

struct mainMenuView: View {
    
    @State public var s = menuBorderIView(menuTitle: "Main Menu", padvalue: 0)
    
    var body: some View {
        
        VStack{
            s
          //  .menuTitle = "hi"
           // s.menuTitle = "hi"
        
        NavigationView {
            
            VStack(spacing: 5){
                
              //  s.menuTitle = ""
                NavigationLink("Learn Mode", destination: learnMode3View())
                    .font(.largeTitle)
                    .frame(width: 500,  alignment: .leading)
                
           } //end vstacki
  
            
        }// end navgation
        .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
}





struct mainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        mainMenuView()
    }
}

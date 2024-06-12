//
//  VCBRootView.swift
//  navigationview
//
//  Created by Billy Cole on 6/12/24.
//

import SwiftUI
import Foundation

struct VCBRootView: View {
    
    var image_connect3 = c3()
    
    var body: some View {
        
        ZStack {
            
        
        NavigationView {
            ScrollView {
                
                
                
                NavigationLink("Manual Adjustment", destination: Manual_Adjustment())
                    .font(.largeTitle)
                
                NavigationLink("LearnMode", destination: LearnMode())
                    .font(.largeTitle)
                
                
                NavigationLink("OCView", destination: OCView())
                    .font(.largeTitle)
                
                NavigationLink("Relief Mode", destination: Relief_Mode())
                    .font(.largeTitle)
                
                NavigationLink("Performance Mode", destination: performanceView())
                    .font(.largeTitle)
                
                
                
            }
            .padding(.top, 500.0) // end scrollView
            //.padding(.bottom, 400.0)
            
            // .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarHidden(true)
            .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
        }
        .navigationViewStyle(StackNavigationViewStyle())
            image_connect3
    }
       // .padding(.top, 300.0)// end  NavigationView
    }
}

struct VCBRootView_Previews: PreviewProvider {
    static var previews: some View {
        VCBRootView()
    }
}

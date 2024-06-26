//
//  VCBRootView.swift
//  navigationview
//
//  Created by Billy Cole on 6/12/24.
//

import SwiftUI
import Foundation
import os
import os.log
import CoreBluetooth


struct VCBRootView: View {
    
    var MaxtonSetupBar = maxtonSetupBar()
    @State private var viewDidLoad = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
         
        
       // .padding(.bottom, 100.0)
        
        
        ZStack {
           // .background(Color.black)
            //
        NavigationView {
           // MaxtonSetupBar
           // ScrollView {
              //  Text("hi ScrollView")
                
                
                VStack{
                    Text("hi vstack")
                    NavigationLink("Manual Adjustment", destination: Manual_Adjustment())
                        .font(.largeTitle)
                        .background(Color.white)
                       // .frame(maxWidth: .infinity, alignment: .center)
                     
                    NavigationLink("LearnMode", destination: learnmodeView2())
                        .font(.largeTitle)
                      //   dismiss()
                    
                    
                    NavigationLink("OCView", destination: OCView())
                        .font(.largeTitle)
                    
                    NavigationLink("Relief Mode", destination: Relief_Mode())
                        .font(.largeTitle)
                    
                    NavigationLink("Performance Mode", destination: performanceView())
                        .font(.largeTitle)
                                           
                    Text("bye vstack")
                        
                    
                    
            }// end vstack
               
                .background(Color.yellow)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.gray)
                
                
                
                Text("bye ScrollView")
                
                
           // }// end scrollView
            
            .padding(.top, 500.0)
            .background(Color.white)
          //  .frame(width: 800, height: 100)
          //  .background(Color.clear)
            
            //Rectangle(width: 400.0, height: 400.0)
            //.frame(width: 600, height: 600)
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarHidden(true)
            .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
            
        }// end NavigationView
            
            
        .navigationViewStyle(StackNavigationViewStyle())
          //  MaxtonSetupBar
               
    }// end ZStack
       
        //.padding(.top, 300.0)// end  NavigationView
        
    } //end var body: some View
    
    
} //end struct VCBRootView: View



struct VCBRootView_Previews: PreviewProvider {
    static var previews: some View {
        VCBRootView()
    }
}

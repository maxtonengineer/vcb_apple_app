//
//  homeScreenView.swift
//  navigationview
//
//  Created by Billy Cole on 6/26/24.
//

import SwiftUI

struct homeScreenView: View {
 //   var stateIndicaters = state_Indicaters()
    @State  var ConnectStatus: String = "No Connect"
    
    var body: some View {
      NavigationView {
        
    VStack{
        //1
        VStack(spacing: 5){
            Text("Maxton")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                //.padding(.bottom,200)
            
            Text("Setup Mode")
            .font(.title)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            
            HStack(spacing: 30){
                
                Text("U")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(Color.red)
                //Text("U").background(Color.red)
                
                Text("UL")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(Color.green)
                
                //.foregroundColor(.black)
                Text("D")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(Color.green)
                
                
                Text("DL")
                    .font(.title)
                    .frame(width:40,height:40,alignment: .center)
                    .background(Color.green)
                
                
                
                
                
            }
            Text("Learn Mode")
                .font(.largeTitle)
            
            HStack(spacing: 30){
                
                Image(systemName: "gamecontroller.fill")
                      .font(.system(size: 50))
                      .foregroundColor(.red)
                
                Text(ConnectStatus)
                    .font(.title)
                    .frame(width:160,height:60,alignment: .center)
                    .background(Color.white)


                
            }

            
            
   
        }
       // .frame(width: 800, height: 40)
        .padding(.top, -390)
        
         
      //  NavigationView {
            
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
          //  .padding(.bottom, 0.0)
            
        //    .navigationBarTitleDisplayMode(.automatic)
          //  .navigationBarHidden(true)
         //   .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)


            
   //     }// end nav veiw
       // .padding(.bottom, 0.0)
     //   .navigationViewStyle(StackNavigationViewStyle())
      //  .frame(width: 800, height: 250)
        }// end VStack 1
    
       
        } //end nav view
        
      .navigationViewStyle(StackNavigationViewStyle())
        
    }// end var body: some View
    
}//end struct homeScreenView: View



/*
 Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
     .font(.largeTitle)
     .padding(.top,00)
     .frame(width: 800,height: 100)
     //.padding(.top,100)

 */














struct homeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        homeScreenView()
    }
}

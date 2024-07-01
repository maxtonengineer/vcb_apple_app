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
                  Text("Main Menu")
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
              .padding(.top, -200)
              
              
              //  NavigationView {
              
              VStack(spacing: 5){
                  
                  //    Text("")
                  NavigationLink("Learn Mode", destination: learnmodeView2())
                      .font(.largeTitle)
                      .frame(width: 500,  alignment: .leading)
                  
                  Divider()
                      .frame(width: 500,alignment: .leading)
                      .frame(height: 1)
                      .overlay(.black)
                  //.padding()
                  
                  NavigationLink("Manual Adjustment", destination: Manual_Adjustment())
                      .font(.largeTitle)
                      .frame(width: 500,  alignment: .leading)
                  
                  
                  Divider()
                      .frame(width: 500,alignment: .leading)
                      .frame(height: 1)
                      .overlay(.black)
                  //.padding()
                  
                  
                  NavigationLink("Performance Mode", destination: performanceView())
                      .font(.largeTitle)
                      .frame(width: 500,  alignment: .leading)
                  
                  
                  
                  Divider()
                      .frame(width: 500,alignment: .leading)
                      .frame(height: 1)
                      .overlay(.black)
                  //.padding()
                  
                  NavigationLink("OSV Mode", destination: OCView())
                      .font(.largeTitle)
                      .frame(width: 500,  alignment: .leading)
                  
                  Divider()
                      .frame(width: 500,alignment: .leading)
                      .frame(height: 1)
                      .overlay(.black)
                  //.padding()
                  
                  
                  
                  NavigationLink("Relief Mode", destination: Relief_Mode())
                      .font(.largeTitle)
                      .frame(width: 500,  alignment: .leading)
                  
                  
                  
                  
              }// end vstack
              .frame(width: 580,height: 270,  alignment: .top)
              //.background(Color.clear)
              .border(.black, width: 2)
              
              VStack {
                  
                  
                  NavigationLink("Inspection Mode", destination: Inspectionview())
                      .font(.largeTitle)
                      .frame(width: 500,  alignment: .leading)
                  
              }
              .frame(width: 580,height: 70,  alignment: .top)
              //.background(Color.clear)
              .border(.black, width: 2)
              
              VStack(spacing: 0) {
                  
                  
                  NavigationLink("Settings", destination: Inspectionview())
                      .font(.largeTitle)
                      .frame(width: 540,height: 70,  alignment: .leading)
                  Divider()
                      .frame(width: 500, height: 1, alignment: .leading)
                      .frame(height: 1)
                      .overlay(.black)
                  
                  NavigationLink("Advanced Settings", destination: Inspectionview())
                      .font(.largeTitle)
                      .frame(width: 540,height: 70,  alignment: .leading)
                  
                  
              }
              .frame(width: 580,height: 170,  alignment: .top)
              //.background(Color.clear)
              .border(.black, width: 2)
              
              //Spacer()
              
              VStack(spacing: 0){
                  //Spacer()
                  NavigationLink("About", destination: aboutScreenView())
                      .font(.largeTitle)
                      .frame(width: 590,height: 70,  alignment: .leading)
              }
               .border(.black, width: 2)
          }// end VStack 1
    
       
        } //end nav view
        
      .navigationViewStyle(StackNavigationViewStyle())
        
    }// end var body: some View
    
}//end struct homeScreenView: View

















struct homeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        homeScreenView()
    }
}


// .frame(width: 580,height: 70,  alignment: .top)

//  .padding(.all,10)



//    .navigationBarTitleDisplayMode(.automatic)
//  .navigationBarHidden(true)
//   .accessibilityLabel("Label")



//     }// end nav veiw
// .padding(.bottom, 0.0)
//   .navigationViewStyle(StackNavigationViewStyle())
//  .frame(width: 800, height: 250)

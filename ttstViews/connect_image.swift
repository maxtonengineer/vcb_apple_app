//
//  connect.swift
//  navigationview
//
//  Created by Billy Cole on 6/12/24.
//
import Foundation
import SwiftUI

struct connect_image: View {
    @State  var connectStatus: String = "No Connect"
    @State var backgroundColorci: Color = Color.white
    
    
    var body: some View {
        HStack(spacing: 30){
            
            ZStack{
               
                Rectangle()
                    .fill(Color.cyan)
                        .frame(width:130, height: 70, alignment: .leading)
                
              Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.red)
            }
            

            
            Text(connectStatus)
                .font(.title)
                .frame(width:160,height:60,alignment: .center)
                .background(Color.white)

            }//end HStack(spacing: 30)

    }
    
    private func setupSubscriptions() {

        nc.addObserver(forName: .connectStatus,
                        object: nil,
                        queue: OperationQueue.main,
                        using: { notification in
             if let payload = notification.object as? BleStatusPayload {
                 
                 if payload.status == BleStatus.connected {
                     self.connectStatus = "connected"
                  //   self.BusStatus.text = " connected"
                  //   self.BusStatus.backgroundColor = .green
                     self.backgroundColorci = .green
                    // print("i am connected") //<-----------------temp debug----------
                 } else if payload.status == BleStatus.disconnected {
                   //  self.BusStatus.text = "disconnected"
                   //  self.BusStatus.backgroundColor = .gray
                     self.backgroundColorci = .gray
                   //  print("i am disconnected") //<-----------------temp debug----------
                     
                 }
                // print("this is my \(payload.value)")
                 //self.RSSI = String(payload.status)
             }
             
           })

        
    }

    
    
    
    
    
}

struct state_Indicaters: View {
    
    //@State var lcolors:Color
    
    var body: some View {
        
        
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
            
            
            
        }//end  HStack(spacing: 30)
        
    }
}  // struct c2: View


struct maxtonSetupBar: View {
    
    var image_connect = connect_image()
    var stateIndicaters = state_Indicaters()

    
    var body: some View {
        
        VStack(alignment: .center, spacing: 30){
         
            
            Text("Maxton")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                
            
           
            Text("Setup Mode")
                .font(.title)
                .frame(maxWidth: .infinity)
                .background(Color.green)
           
            stateIndicaters
            
            image_connect
            

           // .padding(.top, 150.0)

            

           // .font(.caption)
            //.foregroundColor(.white)
            //.padding(.top, 100.0)
            
        }
        .padding(.bottom, 790)// end  VStack(spacing: 60)

       
        
    }
}

struct c4: View {
    
    
    var body: some View {
        
        Text("hi")
    }
    
    
}

 
 struct mainav2: View {
     var body: some View {
         
         Text("hi")
  
         
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
              .padding(.top, 400.0)
             
               .navigationTitle("Home")
              // .navigationBarTitleDisplayMode(.automatic)
               .navigationBarHidden(true)
         }
        // .padding(.top, 300.0)// end  NavigationView
         
      
         
     }// end var body: some View
     
     
 }//end struct mainav: View

 
 











struct connect_Previews: PreviewProvider {
    static var previews: some View {
      //  connect()
       // c3()
        connect_image()
    }
}

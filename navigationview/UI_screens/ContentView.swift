//
//  ContentView.swift
//  navigationview
//
//  Created by Billy Cole on 5/26/24.
//

import SwiftUI
import CoreBluetooth
import os
import Foundation


struct ContentView: View {
    
    @State var foregroundColor: Color = Color.blue
    
    var body: some View {
   // VStack {
        foregroundColor
Text("r")
     
    //    } // END VSTACK
        
    }// end  var body: some View
    
    func foo(){
        modelRef.getRssi()
        bleRef.attachPeripheral(suuid: motorServiceUuid)
    }
}// end struct ContentView: View
        
 
        
        
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  InspectioncontrView.swift
//  navigationview
//
//  Created by Tim Fan on 7/22/24.
//

import SwiftUI

struct InspectioncontrView: View {
    
    @State  var carSpeedAdj: Int = 0

    
    var body: some View {
        
        
        ZStack{
            
            HStack{
                
                
                
                Image(systemName: "arrowtriangle.up.fill")
                    .resizable()
                    .position(x:900,y:390)
                
                    .frame(width: 50,height: 50)
                    .font(.system(size: 40))
                    .onTapGesture {
                        carSpeedAdj = carSpeedAdj + 1
                    }
                // .foregroundColor(limageColor)
                   // .position(x:0,y:0)
                Text(String(carSpeedAdj))
                    
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .frame(width: 100,height: 50)
                    .position(x:710,y:400)
                
                
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .position(x:200,y:400)
                    .frame(width: 50,height: 50)
                    .font(.system(size: 40))
                    .onTapGesture {
                        
                        carSpeedAdj = carSpeedAdj - 1
                    }
                // .foregroundColor(limageColor)
                   
                
                
            }// end hstack
           // .border(Color.red, width: 5)
            .frame(width: 500,height: 70)
            .position(x:10,y:100)
            
              //  .background(Color.red)
               // .frame(width: 500,height: 70)
            Rectangle()
                .frame(width: 400,height: 90)
                .foregroundColor(Color.clear)
                .border(Color.gray,width: 4)
                .cornerRadius(10)
                .position(x:530,y:470)
                
        }// end zstack
        .frame(width: 800,height: 800)
        .position(x:200,y:200)
        
        
        
        
    }//end var body
    
    
    
}






















#Preview {
    InspectioncontrView()
}

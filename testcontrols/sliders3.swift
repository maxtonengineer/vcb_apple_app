//
//  sliders3.swift
//  navigationview
//
//  Created by Billy Cole on 6/26/24.
//

import SwiftUI

struct sliders3: View {
    
    @State private var value = 0
    let colors: [Color] = [.orange, .red, .gray, .blue,
                           .green, .purple, .pink]


    func incrementStep() {
        value += 1
        if value >= colors.count { value = 0 }
    }


    func decrementStep() {
        value -= 1
        if value < 0 { value = colors.count - 1 }
    }


    var body: some View {
        Stepper {
            Text("Value: \(value) Color: \(colors[value].description)")
        } onIncrement: {
            incrementStep()
        } onDecrement: {
            decrementStep()
        }
        .padding(5)
        .background(colors[value])
    }
 
}




struct StepperView: View {
    @State private var value = 0
    let step = 5
    let range = 1...50


    var body: some View {
        Stepper(
            value: $value,
            in: range,
            step: step
        ) {
            Text("Current: \(value) in \(range.description) " +
                 "stepping by \(step)")
        }
        .padding(10)
    }
}









struct sliders3_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        StepperView()
    }
    
    
    
    
    
}

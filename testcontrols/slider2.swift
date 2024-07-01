//
//  slider2.swift
//  navigationview
//
//  Created by Billy Cole on 6/26/24.
//

import SwiftUI
import Charts

struct slider2: View {
    @State private var speed = 50.0
    @State private var isEditing = false


    var body: some View {
        Slider(
            value: $speed,
            in: 0...100,
            step: 5
        ) {
            Text("Speed")
        } minimumValueLabel: {
            Text("0")
        } maximumValueLabel: {
            Text("100")
        } onEditingChanged: { editing in
            isEditing = editing
        }
        Text("\(speed)")
            .foregroundColor(isEditing ? .red : .blue)
    }
        
}





struct SliderExample: View {
    /// A bindable property that holds the current value of the slider
    @State private var volume: Double = 50

    /// The main view content which is rendered and displayed on the screen
    var body: some View {
        /// A VStack containing a label and the `Slider`.
        VStack(spacing: 20) {
            /// Display the current volume as a percentage
            Text("Volume: \(Int(volume))%")
                .font(.title2)

            /// A slider allowing adjustment of the volume between 0 and 100.
            Slider(value: $volume, in: 0...100) {
                Text("Volume")
            }
            .padding()
        }
        .padding()
    }
}


struct SwiftUItestView: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    
    var body: some View {
        VStack {
                Slider(
                    value: $speed,
                    in: 0...100,
                    onEditingChanged: { editing in
                        isEditing = editing
                    }
                )
                Text("\(speed)")
                    .foregroundColor(isEditing ? .red : .blue)
            }
    }
}



struct SwiftUItestView2: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    
    
    var body: some View {
        Slider(
            value: $speed,
            in: 0...100,
            step: 5
        ) {
            Text("Speed")
        } minimumValueLabel: {
            Text("0")
        } maximumValueLabel: {
            Text("100")
        } onEditingChanged: { editing in
            isEditing = editing
        }
        Text("\(speed)")
            .foregroundColor(isEditing ? .red : .blue)
    }
    
}













struct SliderExample_Previews: PreviewProvider {
    static var previews: some View {
        SliderExample()
    }
}

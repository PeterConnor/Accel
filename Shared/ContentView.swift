//
//  ContentView.swift
//  Shared
//
//  Created by Pete Connor on 3/26/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var motionManager = MotionManager()
    
    var body: some View {
        
        // Show accelerometer data if button is pushed. Otherwise, show button.
        
        if motionManager.isAccelerometerActive == true {
            Text("X:  \(motionManager.accelerometerValues?.last?.x ?? 0.0)")
                .modifier(ButtonModifier())
            Text("Y: \(motionManager.accelerometerValues?.last?.y ?? 0.0)")
                .modifier(ButtonModifier())
            Text("Z: \(motionManager.accelerometerValues?.last?.z ?? 0.0)")
                .modifier(ButtonModifier())
        } else {
            Button(action: {
                motionManager.startAccelerometer()
            }, label: {
                Text("Start Accelerometer")
                    .foregroundColor(.white)
        
                
            })
            .modifier(ButtonModifier())
        }
    }
}

// Custom ViewModifier for buttons and accelerometer data labels.

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 50, alignment: .center)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

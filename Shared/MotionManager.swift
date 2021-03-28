//
//  MotionManager.swift
//  Accel
//
//  Created by Pete Connor on 3/26/21.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
        
    let motion = CMMotionManager()
    
    // Create an optional array to store accelerometer values.
    
    @Published var accelerometerValues: [(x: Double, y: Double, z: Double)]?
    
    // Track whether the accelerometer data is being recorded.
    
    @Published var isAccelerometerActive = false
    
    func startAccelerometer() {
        
        // Check if accelerometer hardware is available.
        
        if self.motion.isAccelerometerAvailable {
            
            // Set accelerometer Hz to 50.
            
            self.motion.accelerometerUpdateInterval = 1.0 / 50.0
            
            self.motion.startAccelerometerUpdates()
            
            // Create a counter to track timer intervals.
            
            var counter = 0
            
            isAccelerometerActive = true
            
            // Set up accelerometer timer to fire 50 times per second.

            let timer = Timer(fire: Date(), interval: 1.0 / 50.0, repeats: true, block: { (timer) in
                
                // Get accelerometer data.
                
                if let data = self.motion.accelerometerData {

                    // If accelerometerValues is not nil, we can append to the array. Otherwise, we need to set the initial value of the array.
                    
                    if self.accelerometerValues != nil {
                        self.accelerometerValues?.append((x: data.acceleration.x, data.acceleration.y, z: data.acceleration.z))
                    } else {
                        self.accelerometerValues = [(data.acceleration.x, data.acceleration.y, data.acceleration.z)]
                    }
                }
                
                // Count to 10 seconds, invalidate the timer, and set isAccelerometerActive to false. (50 readings per second for 10 seconds is 500 readings/counts).
                
                counter += 1
                
                if counter >= 500 {
                    timer.invalidate()
                    self.isAccelerometerActive = false
                    
                    // Make sure accelerometerData is not nil before writing to documents directory.
                    
                    if let finalAccelerometerValues = self.accelerometerValues {
                        writeToFile(accelerometerData: finalAccelerometerValues)
                    }
                }
                
            })
            
            // Add the timer to the current run loop.
            
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
            
        }
        
    }
    
}

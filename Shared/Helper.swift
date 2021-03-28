//
//  Helper.swift
//  Accel
//
//  Created by Pete Connor on 3/28/21.
//

import Foundation

// Write accelerometer data to documents directory.

func writeToFile(accelerometerData: [(x: Double, y: Double, z: Double)]?) {
    
    // Get documents directories for the user.
    
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // Get the first directory.
    
    let documentDirectory = paths[0]
    
    // Name the file.
    
    let url = documentDirectory.appendingPathComponent("accelerometerdata.txt")
    
    // Convert accelerometer data to string.
    
    let stringData = String(describing: accelerometerData)

    // Write accelerometer data to documents directory.
    
    do {
        try stringData.write(to: url, atomically: true, encoding: .utf8)
        
        // Print the stored accelerometer data from documents directory to the console.
        
        let fileInput = try String(contentsOf: url)
        print("fileInput: \(fileInput)")
    } catch {
        print(error.localizedDescription)
    }
        
}

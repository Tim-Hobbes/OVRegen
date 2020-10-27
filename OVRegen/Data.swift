//
//  Data.swift
//  OVRegen
//
//  Created by Tim Hobbes on 21/10/2020.
//

import SwiftUI

struct Journey: Codable, Identifiable {
    var id = UUID()
    var arrivalTime: Date?
    var beginTime: Date?
    var link: String?
    
    var type: Int? //0 for OV, 1 for bike
    
    var rain: Double?
    var beginning: LatLong?
}

struct LatLong: Codable {
    var lat: Double
    var long: Double
}

class mainLogic {
    func bikeOrOV (origin: String, destination: String, timeToLeave: Date, rainHate: Double, competion: @escaping (Int) -> ()){
        
        GraphhopperApi().getTime(fromString: origin, toString: destination, startTime: timeToLeave) { (bikeJourney) in
            var bikeOrOVInt: Int = 1
            
            let inverseRainHate = 1 - rainHate
            
            if bikeJourney.rain! >= inverseRainHate {
                    print("fuck")
                    bikeOrOVInt = 0
            }
            
            DispatchQueue.main.async {
                competion(bikeOrOVInt)
            }
        }
    }
}

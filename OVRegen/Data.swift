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
    func bikeOrOV (origin: String, destination: String, timeToLeave: Date, rainHate: Double){
        
        GraphhopperApi().getTime(fromLad: 52.3837866, fromLng: 4.6078594, toLad: 52.3550197, toLng: 4.6384034) { (paths) in
            print(paths.time)
        }
        //calculate the possible routes with the 9292 api
        NegenTweeNegenTweeApi().getRoutes(from: origin, to: destination, departureTime: timeToLeave) { (journeys) in
            OpenWeatherMapApi().getRain(journey: journeys[0])
            print (journeys[0].link)
        }
    }
}

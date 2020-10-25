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
    
    var rain: Double?
}

class mainLogic {
    func bikeOrOV (origin: String, destination: String, timeToLeave: Date, rainHate: Double){
        
        //calculate the possible routes with the 9292 api
        NegenTweeNegenTweeApi().getRoutes(from: origin, to: destination, departureTime: timeToLeave) { (journeys) in
            print (journeys[0].link)
        }
    }
}

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
        NegenTweeNegenTweeApi().getId(query: origin) { (originId) in
            NegenTweeNegenTweeApi().getId(query: destination) { (destinationId) in
                NegenTweeNegenTweeApi().getRoutes(fromId: originId.id, toId: destinationId.id, departureTime: timeToLeave) { (journeys) in
                    
                    
                    
                }
            }
        }
    }
}

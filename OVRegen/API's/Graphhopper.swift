//
//  Graphhopper.swift
//  OVRegen
//
//  Created by Dinand Put on 25/10/2020.
//

import SwiftUI

class GraphhopperApi {
    
    struct Results: Codable {
        var paths: [Paths]
    }
    
    struct Paths: Codable {
        var time: Int
    }

    func getTime (fromString: String, toString: String, startTime: Date, completion: @escaping (Journey) -> ()){
        NegenTweeNegenTweeApi().getLocation(query: fromString) { (from) in
            NegenTweeNegenTweeApi().getLocation(query: toString) { (to) in
                let key = "a2315e51-801e-440c-93ad-8c890ec4fddb"
                
                let urlString = "https://graphhopper.com/api/1/route?point=\(from.latLong.lat),\(from.latLong.long )&point=\(to.latLong.lat),\(to.latLong.long)&vehicle=bike&calc_points=false&key=\(key)"
                guard let url = URL(string: urlString) else {return}
                
                print(url)
                print(urlString)
                
                URLSession.shared.dataTask(with: url) { (data, _, _) in
                    if (data == nil) {
                        print("No data")
                        return
                    }
                    print(data)
                    //decode the json data
                    
                    let jsonDecoder = JSONDecoder()
                    let apiResult = try? jsonDecoder.decode(Results.self, from: data!)
                    
                    print(apiResult?.paths[0].time)
                    
                    
                    var journey = Journey() 
                    journey.beginTime = startTime
                    journey.arrivalTime = startTime + TimeInterval((apiResult?.paths[0].time)!/1000)
                    journey.type = 1
                    journey.beginning = from.latLong
                    journey.link = "https://www.google.com/maps/dir/?api=1&origin=\(from.latLong.lat),\(from.latLong.long)&destination=\(to.latLong.lat),\(to.latLong.long)&travelmode=bicycling"
                  
                    OpenWeatherMapApi().getRain(journey: journey) { (journey) in
                        DispatchQueue.main.async {
                            completion(journey)
                        }
                    }
                    
                    
                    
                    
                }.resume()
            }
        }
    }
    
}

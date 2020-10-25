//
//  OpenWeatherMap.swift
//  OVRegen
//
//  Created by Tim Hobbes on 25/10/2020.
//

import SwiftUI

class OpenWeatherMapApi {
    let key = "075224cab0df4279260fe8bf1e80b04f"

    struct TotalResults: Codable {
        var hourly: [HourResult]
    }
    
    struct HourResult: Codable {
        var dt: Int
        var pop: Double
        var time: Date?
    }
    
    
    func getRain (journey: Journey, completion: @escaping (Journey) -> ()) {
        if journey.beginning == nil {
            print("get rain called without beginning")
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(journey.beginning!.lat)&lon=\(journey.beginning!.long)&appid=\(self.key)"
        
        guard let url = URL(string: urlString) else {return}
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if (data == nil)  {
                print("no weather data")
                return
            }
            
            //print(String(decoding: data!, as: UTF8.self))
            
            //decode json data
            
            let jsonDecoder = JSONDecoder()
            var jsonCatalogs = try? jsonDecoder.decode(TotalResults.self, from: data!)
            
            if jsonCatalogs == nil {
                return
            }
            
            for i in 0...(jsonCatalogs!.hourly.count)-1 {
                jsonCatalogs!.hourly[i].time = Date(timeIntervalSince1970: TimeInterval(jsonCatalogs!.hourly[i].dt))
            }
            
            var popInJourney: Double = 0
            var amoundOfPops: Double = 0 //Double because it has to be devided
            
            for i in 0...(jsonCatalogs!.hourly.count)-1 {
                
                //check if if the current data point is beween the depature time and the arrival time of the journey. Add an hour onto the arrivaltime to make sure there is at least one data point.
                if ((journey.arrivalTime! + TimeInterval(3600)) >= jsonCatalogs!.hourly[i].time! && journey.beginTime! <= jsonCatalogs!.hourly[i].time!){
                    
                    //add the pop of the currentt data point onto the list of popInJourney so we can calculate a avarage
                    popInJourney += jsonCatalogs!.hourly[i].pop
                    amoundOfPops += 1
                }
            }
            
            let avgPop = popInJourney/amoundOfPops
            
            print("avgPop: \(avgPop)")
            
            var jour = journey //make a copy of journey because it is at let and not a var
            
            jour.rain = avgPop
            
            DispatchQueue.main.async {
                completion(jour)
            }
        }.resume()
    }
    
}

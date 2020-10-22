//
//  Data.swift
//  OVRegen
//
//  Created by Tim Hobbes on 21/10/2020.
//

import SwiftUI

struct Journey: Codable, Identifiable {
    let id = UUID()
    var arrivalTime: Date?
    var beginTime: Date?
    var link: String?
}

class NegenTweeNegenTweeApi {
    struct JsonJourneys: Codable {
        var journeys: [JsonJourney]
    }
    
    struct JsonJourney: Codable {
        var id: String
        var departure: String
        var arrival: String
    }
    
    
    func getRoutes (fromId: String, toId: String, departureTime: Date) {
        //make swift understand the wird date notation the API
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HHmm";
        
        //genarate thre url to be requested, if it can't be created for some reason return the function without result
        let urlString = "https://api.9292.nl/0.1/journeys?before=1&sequence=1&byFerry=true&bySubway=True&byBus=true&byTrain=true&lang=nl-NL&searchType=departure&interchangeTime=standard&after=5&from=\(fromId)&to=\(toId)&dateTime=\(dateFormatter.string(from: departureTime))"
        
        
        guard let url = URL(string: urlString)
        else {return}
        
        print("URL = " + url.absoluteString)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in //make a request to the 9292 servers, if it returns call this function with the argument data for the data of the function and ignore the response code and the error code.
            if (data == nil) {
                print("No data")
                return()
            }
            
            
            //decode the json data
            
            let jsonDecoder = JSONDecoder()
               
            let jsonCatalogs = try? jsonDecoder.decode(JsonJourneys.self, from: data!)
            print (jsonCatalogs?.journeys[0].arrival)
            
            //tranlate the 9292 format to our format
            var journeys: [Journey] = []//init string of journeys
            
            
            guard let amoundOfJourneys = jsonCatalogs?.journeys.count else {return}

            //make swift understand the wird date notation the API, this is slightly different than in the one of the bigging of the function becasue the API return a time with a : between the hour and the minute
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm";
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") //more reliable https://stackoverflow.com/questions/36861732/convert-string-to-date-in-swift
            
            for i in 0...amoundOfJourneys-1 {
                var journey = Journey()

                //convert the string time that is returned form the API into swift Date objects, if it fails let it be now.
                journey.arrivalTime = dateFormatter.date(from: jsonCatalogs!.journeys[i].arrival)
                journey.beginTime = dateFormatter.date(from: jsonCatalogs!.journeys[i].departure)
                
                journey.link = self.generateLink(departure: journey.beginTime, from: fromId, to: toId);
                
                journeys.append(journey)
            }
            
            print(journeys)
            
        }
        .resume()
    }
    
    func generateLink(departure: Date?, from: String?, to: String?) -> String? {
        //make swift understand the wird date notation the API
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HHmm";
        
        if departure == nil || from == nil || to == nil { //check if all the values needed for the expression are available
            return ""
        }
        
        let link: String = "https://9292.nl/reisadvies/\(from!)/\(to!)/vertrek/\(dateFormatter.string(from: departure!))?extraInterchangeTime=0"
        
        return link
    }
}

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
    
    struct Locations: Codable {
        var locations: [Location]
    }
    
    struct Location: Codable {
        var id: String
    }
    
    
    func getId (query: String, completion: @escaping (Location) -> ()){
        let escapedQuery  = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let urlString = "https://api.9292.nl/0.1/locations?lang=nl-NL&q=\(escapedQuery!)"
        guard let url = URL(string: urlString) else {return}
        
        print (urlString)
        print (url)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if (data == nil) {
                print("No data")
                return
            }
            
            //decode the json data
            
            let jsonDecoder = JSONDecoder()
            let jsonCatalogs = try? jsonDecoder.decode(Locations.self, from: data!)
            
            if jsonCatalogs == nil {
                return
            }
            
            print ("jsonCatalogs.locations.count = \(jsonCatalogs!.locations.count)")
            
            if jsonCatalogs!.locations.count == 0 {
                return
            }
            
            DispatchQueue.main.async {
                completion(jsonCatalogs!.locations[0])
            }
            
        }.resume()
    }
    
    
    func getRoutes (fromId: String, toId: String, departureTime: Date, completion: @escaping ([Journey]) -> ()) {
        //make swift understand the wird date notation the API
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HHmm";
        
        //genarate thre url to be requested, if it can't be created for some reason return the function without result
        let urlString = "https://api.9292.nl/0.1/journeys?before=1&sequence=1&byFerry=true&bySubway=True&byBus=true&byTrain=true&lang=nl-NL&searchType=departure&interchangeTime=standard&after=5&from=\(fromId)&to=\(toId)&dateTime=\(dateFormatter.string(from: departureTime))"
        
        
        guard let url = URL(string: urlString) else {return}
        
        print("URL = " + url.absoluteString)
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in //make a request to the 9292 servers, if it returns call this function with the argument data for the data of the function and ignore the response code and the error code.
            if (data == nil) {
                print("No data")
                return()
            }
            
            
            //decode the json data
            
            let jsonDecoder = JSONDecoder()
            let jsonCatalogs = try? jsonDecoder.decode(JsonJourneys.self, from: data!)
            
            //tranlate the 9292 format to our format
            var journeys: [Journey] = []//init string of journeys
            guard let amoundOfJourneys = jsonCatalogs?.journeys.count else {return}

            //make swift understand the wird date notation the API, this is slightly different than in the one of the bigging of the function becasue the API return a time with a : between the hour and the minute
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm";
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") //fixed a wird issue, don't know how it works
            
            for i in 1...amoundOfJourneys-1 { //thow away the first journey because it is planned before the departure time
                var journey = Journey()

                //convert the string time that is returned form the API into swift Date objects, if it fails let it be now.
                journey.arrivalTime = dateFormatter.date(from: jsonCatalogs!.journeys[i].arrival)
                journey.beginTime = dateFormatter.date(from: jsonCatalogs!.journeys[i].departure)
                
                //generate the link to display more info about the journey
                journey.link = self.generateLink(departure: journey.beginTime, from: fromId, to: toId);
                
                journeys.append(journey)
            }
            
            DispatchQueue.main.async {
                completion(journeys)
            }
            
            print(journeys)
            
        }
        .resume() //make the request!
    }
    
    func generateLink(departure: Date?, from: String?, to: String?) -> String? {
        //make swift understand the wird date notation the API
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HHmm";
        
        if departure == nil || from == nil || to == nil { //check if all the values needed for the expression are available, optionals in String behave wirdly
            return "https://9292.nl"
        }
        
        //in the url the / in the id's are replaced with _
        let fromUrlId = from!.replacingOccurrences(of: "/", with: "_")
        let toUrlId = to!.replacingOccurrences(of: "/", with: "_")
        
        let link: String = "https://9292.nl/reisadvies/\(fromUrlId)/\(toUrlId)/vertrek/\(dateFormatter.string(from: departure!))?extraInterchangeTime=0"
        
        return link
    }
}

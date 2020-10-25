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

    func getTime (fromLad: Double, fromLng: Double, toLad: Double, toLng: Double, completion: @escaping (Paths) -> ()){
        let key = "a2315e51-801e-440c-93ad-8c890ec4fddb"
        
        let urlString = "https://graphhopper.com/api/1/route?point=\(fromLad),\(fromLng)&point=\(toLad),\(toLng)&vehicle=bike&calc_points=false&key=\(key)"
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
            
          
            
            
            
        }.resume()
    }
    
}

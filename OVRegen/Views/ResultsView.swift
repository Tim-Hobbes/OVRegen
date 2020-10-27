//
//  ResultsView.swift
//  OVRegen
//
//  Created by Dinand Put on 28/10/2020.
//

import SwiftUI

struct ResultsView: View {
    @State var planOrigin: String
    @State var planDestination: String
    
    @State var timeToLeave: Date
    
    @State var rainHate: Double
    
    @State var trainOrBike: Int?
    //0 for OV, 1 for Bike
    
    
    var body: some View {
        VStack {
            if trainOrBike == 0 {
                Text("🚂")
                    .font(.system(size: 150))
                Text("F*ck die regen, beter pak je het OV")
                RoutesView(planOrigin: planOrigin, planDestination: planDestination, timeToLeave: timeToLeave, rainHate: rainHate)
            } else if trainOrBike == 1 {
                Text("🚲")
                    .font(.system(size: 100))
                Text("Gozer je wordt geeneens nat")
                
                Link(destination: URL(string: "https://www.google.com/maps/dir/?api=1&origin=\(planOrigin.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&destination=\(planDestination.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&travelmode=bicycling")!){
                    VStack{
                    Text("Klik hier voor een route beschrijving")
                    Image("Googlemap").resizable().scaledToFit().frame(width: 100, height: 100, alignment: .center)
                    }
                }

            } else {
                ProgressView()
            }
                

    }.onAppear {
            
            mainLogic().bikeOrOV(origin: planOrigin, destination: planDestination, timeToLeave: timeToLeave, rainHate: rainHate) { (result) in
                trainOrBike = result
                
            }
        }
    
    }


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(planOrigin: "haarlem", planDestination: "Spaarndam", timeToLeave: Date(), rainHate: 0.2, trainOrBike: 0)    }
}

}

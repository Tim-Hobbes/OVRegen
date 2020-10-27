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
            } else {
                Text("🚲")
                    .font(.system(size: 150))
                Text("Gozer je wordt geeneens nat")
            }
            RoutesView(planOrigin: planOrigin, planDestination: planDestination, timeToLeave: timeToLeave, rainHate: rainHate)
            }
    }
}


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(planOrigin: "haarlem", planDestination: "Spaarndam", timeToLeave: Date(), rainHate: 0.2, trainOrBike: 0)    }
}

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
    
    
    var body: some View {
        VStack {
            Text("🚂")
                .font(.system(size: 150))
            Text("Het openbaar vervoer is jouw beste keuze")
            RoutesView(planOrigin: planOrigin, planDestination: planDestination, timeToLeave: timeToLeave, rainHate: rainHate)
            }
    }
}


struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(planOrigin: "haarlem", planDestination: "Spaarndam", timeToLeave: Date(), rainHate: 0.2)    }
}

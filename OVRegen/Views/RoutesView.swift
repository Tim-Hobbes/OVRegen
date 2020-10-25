//
//  RoutesView.swift
//  OVRegen
//
//  Created by Tim Hobbes on 20/09/2020.
//

import SwiftUI

struct RoutesView: View {
    @State var journeys: [Journey] = []
    
    @State var planOrigin: String
    @State var planDestination: String
    
    @State var timeToLeave: Date
    
    @State var rainHate: Double
    
    
    static let routeDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        List(journeys) { journey in
            Link(destination: URL(string: journey.link!)!) {
                VStack {
                    Text("🚉").font(.title).multilineTextAlignment(.center)
                    Text("Vertrektijd: \(journey.beginTime!, formatter: Self.routeDateFormat)")
                    Text("Aankomsttijd: \(journey.arrivalTime!, formatter: Self.routeDateFormat)")
                }
            }
        }.onAppear {
            mainLogic().bikeOrOV(origin: planOrigin, destination: planDestination, timeToLeave: timeToLeave, rainHate: rainHate)
        }.navigationBarTitle("Routes")
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesView(planOrigin: "Lieoever 54", planDestination: "Wolff en dekenlaan 1", timeToLeave: Date(), rainHate: 0.5)
    }
}

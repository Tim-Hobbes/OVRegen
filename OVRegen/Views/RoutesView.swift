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
            print("Hi, Dinand!")
            NegenTweeNegenTweeApi().getRoutes(from: planOrigin, to: planDestination, departureTime: timeToLeave) { (journeys) in
                self.journeys = journeys
                print(journeys)
            }
        }
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesView(planOrigin: "haarlem", planDestination: "groningen", timeToLeave: Date(), rainHate: 0.5)
    }
}

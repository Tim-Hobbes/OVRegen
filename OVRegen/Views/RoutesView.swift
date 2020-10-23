//
//  RoutesView.swift
//  OVRegen
//
//  Created by Tim Hobbes on 20/09/2020.
//

import SwiftUI

struct RoutesView: View {
    @State var journeys: [Journey] = []
    
    static let routeDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        List(journeys) { journey in
            Text("OV: \(journey.arrivalTime!, formatter: Self.routeDateFormat)")
            }
        
        }.onAppear {
            NegenTweeNegenTweeApi().getRoutes(fromId: "haarlem/lieoever-54", toId: "driehuis/wolff-en-dekenlaan-10", departureTime: Date()) { (journeys) in
                self.journeys = journeys
            }
        }
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesView()
    }
}

//
//  9292routelist.swift
//  OVRegen
//
//  Created by Tim Hobbes on 21/10/2020.
//

import SwiftUI

struct _292routelist: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                NegenTweeNegenTweeApi().getRoutes(fromId: "station-amsterdam-centraal", toId: "station-eindhoven", departureTime: Date())
            }
    }
}

struct _292routelist_Previews: PreviewProvider {
    static var previews: some View {
        _292routelist()
    }
}

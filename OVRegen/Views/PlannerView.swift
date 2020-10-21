//
//  Planner.swift
//  OVRegen
//
//  Created by Tim Hobbes on 20/09/2020.
//

import SwiftUI

struct PlannerView: View {
    @State private var showDetails = false
    
    @State var planOrigin = ""
    @State var planDestination = ""
    
    @State private var timeToLeave = Date()
    
    @State private var rainHate: Double = 0
    
    var body: some View {
        Form {
            //TODO adress autocomplete
            HStack {
                Text("◯")
                TextField("Wolff en Dekenlaan 1", text: $planOrigin)
            }
            HStack {
                Text("📍")
                TextField("Naar: Spaarne 16", text: $planDestination)
            }
            
            
            DatePicker("🕒", selection: $timeToLeave)
            
            HStack {
                Text("😡 🌧️" )
                Slider(value: $rainHate, in: 0...1, step: 0.01)
            }
        }
    }
    
}

struct PlannerView_Previews: PreviewProvider {
    static var previews: some View {
        PlannerView()
    }
}


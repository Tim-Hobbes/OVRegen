//
//  ContentView.swift
//  OVRegen
//
//  Created by Tim Hobbes on 20/09/2020.

import SwiftUI

struct ContentView: View {
    @State var planOrigin = ""
    @State var planDestination = ""
    
    @State var timeToLeave = Date()
    
    @State var rainHate: Double = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
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
                NavigationLink(destination: RoutesView(planOrigin: planOrigin, planDestination: planDestination, timeToLeave: timeToLeave, rainHate: rainHate)) {
                    Text("Plan!?").font(.title)
                }
                Spacer()
            }.navigationTitle("💦 🚌/🚴‍♀️ OVRegen")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

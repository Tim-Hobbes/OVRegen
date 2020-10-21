//
//  ContentView.swift
//  OVRegen
//
//  Created by Tim Hobbes on 20/09/2020.

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                PlannerView()
                NavigationLink(destination: RoutesView()) {
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

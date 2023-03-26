//
//  RandomJokeApp.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

import SwiftUI

@main
struct RandomJokeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    RandomJokeView()
                }
                .tabItem {
                    Label {
                        Text("Joke")
                    } icon: {
                        Image(systemName: "j.circle")
                    }
                }
            }
            .tint(.white)
        }
    }
}

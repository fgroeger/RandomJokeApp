//
//  RandomJokeState.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

import SwiftUI

struct RandomJokeState {
    var hue: Double
    var currentJoke: CurrentJoke
}

extension RandomJokeState {
    enum CurrentJoke {
        case loading
        case joke(Joke)
        case error
    }
}

extension RandomJokeState.CurrentJoke {
    struct Joke {
        var setup: String
        var punchline: String
        var isFavorite: Bool
    }
}

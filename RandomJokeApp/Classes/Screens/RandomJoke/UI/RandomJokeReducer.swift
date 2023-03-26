//
//  RandomJokeViewModel.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

import Combine
import SwiftUI

final class RandomJokeReducer: Reducer {
    typealias State = RandomJokeState
    typealias Action = RandomJokeAction
    
    func reduce(state: inout RandomJokeState, action: RandomJokeAction) {
        switch action {
            case .onAppear:
                break
                
            case .refreshJoke:
                state.setup = ""
                state.punchline = ""
                state.isFavorite = false
                
            case .favorite:
                state.isFavorite.toggle()
                
            case let .randomJokeChanged(joke):
                state.hue = .random(in: 0...1)
                state.setup = joke.setup
                state.punchline = joke.punchline
                state.isFavorite = false
        }
    }
}

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
                state.currentJoke = .loading
                
            case .favorite:
                switch state.currentJoke {
                    case .loading:
                        break
                        
                    case let .joke(joke):
                        state.currentJoke = .joke(
                            .init(
                                setup: joke.setup,
                                punchline: joke.punchline,
                                isFavorite: !joke.isFavorite
                            )
                        )
                        
                    case .error:
                        state.currentJoke = .error
                }
                
            case let .randomJokeChanged(joke):
                state.hue = .random(in: 0...1)
                state.currentJoke = .joke(
                    .init(
                        setup: joke.setup,
                        punchline: joke.punchline,
                        isFavorite: false
                    )
                )
                
            case .randomJokeRefreshFailed:
                state.currentJoke = .error
        }
    }
}

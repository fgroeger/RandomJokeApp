//
//  RandomJokeAction.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

enum RandomJokeAction {
    case onAppear
    case refreshJoke
    case favorite
    
    // reactive
    case randomJokeChanged(RandomJoke)
}

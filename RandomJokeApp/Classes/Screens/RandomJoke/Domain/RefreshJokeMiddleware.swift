//
//  RefreshJokeMiddleware.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

struct RefreshJokeMiddleware: Middleware {
    typealias State = RandomJokeState
    typealias Action = RandomJokeAction
    
    private let randomJokeService: RandomJokeService
    
    init(service: RandomJokeService) {
        self.randomJokeService = service
    }
    
    func handle(action: RandomJokeAction, in state: RandomJokeState) -> any Effect<RandomJokeAction> {
        guard case .refreshJoke = action else { return DoNothingEffect() }
        
        randomJokeService.refreshRandomJoke()
        return DoNothingEffect()
    }
}

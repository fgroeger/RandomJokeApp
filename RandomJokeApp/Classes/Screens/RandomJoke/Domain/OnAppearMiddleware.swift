//
//  OnAppearMiddleware.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

struct OnAppearMiddleware: Middleware {
    typealias State = RandomJokeState
    typealias Action = RandomJokeAction
    
    private let randomJokeService: RandomJokeService
    
    init(service: RandomJokeService) {
        self.randomJokeService = service
    }
    
    func handle(action: RandomJokeAction, in state: RandomJokeState) -> any Effect<RandomJokeAction> {
        guard case .onAppear = action else { return DoNothingEffect() }
        
        let publisher = randomJokeService.randomJokePublisher
            .map { randomJoke in
                return RandomJokeAction.randomJokeChanged(randomJoke)
            }
            .eraseToAnyPublisher()
        
        return SubscribeEffect(publisher)
    }
}

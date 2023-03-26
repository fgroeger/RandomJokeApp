//
//  RandomJokeStoreFactory.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

struct RandomJokeStoreFactory {
    func createStore() -> Store<RandomJokeState, RandomJokeAction> {
        Store(
            initialState: RandomJokeState(
                hue: .random(in: 0...1),
                setup: "",
                punchline: "",
                isFavorite: false
            ),
            middlewares: [
                RefreshJokeMiddleware(service: .shared),
                SubscribeToRandomJokeMiddleware(service: .shared)
            ],
            reducer: RandomJokeReducer()
        )
    }
}

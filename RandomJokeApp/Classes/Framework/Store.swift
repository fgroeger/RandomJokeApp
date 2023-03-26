//
//  Store.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

import Combine
import SwiftUI

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    let middlewares: [any Middleware<State, Action>]
    let reducer: any Reducer<State, Action>
    
    private var effectSubscriptions: Set<AnyCancellable> = []
    
    init(
        initialState: State,
        middlewares: [any Middleware<State, Action>],
        reducer: some Reducer<State, Action>
    ) {
        self.state = initialState
        self.middlewares = middlewares
        self.reducer = reducer
    }
    
    @MainActor func dispatch(_ action: Action) {
        reducer.reduce(state: &state, action: action)
        
        for middleware in middlewares {
            middleware.handle(action: action, in: state)
                .createPublisher()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] effectAction in
                    self?.dispatch(effectAction)
                }
                .store(in: &effectSubscriptions)
        }
    }
}

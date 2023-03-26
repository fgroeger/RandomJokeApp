//
//  Effect.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

import Combine

typealias EffectPublisher<Action> = AnyPublisher<Action, Never>

protocol Effect<Action> {
    associatedtype Action
    
    func createPublisher() -> EffectPublisher<Action>
}

struct AwaitEffect<Action>: Effect {
    let closure: () async -> Action
    
    init(_ closure: @escaping () async -> Action) {
        self.closure = closure
    }
    
    func createPublisher() -> EffectPublisher<Action> {
        Future { promise in
            Task {
                let effect = await closure()
                promise(.success(effect))
            }
        }
        .eraseToAnyPublisher()
    }
}

struct SubscribeEffect<Action>: Effect {
    let publisher: AnyPublisher<Action, Never>
    
    init(_ publisher: AnyPublisher<Action, Never>) {
        self.publisher = publisher
    }
    
    func createPublisher() -> EffectPublisher<Action> {
        publisher
    }
}

struct DoNothingEffect<Action>: Effect {
    func createPublisher() -> EffectPublisher<Action> {
        Just(())
            .compactMap { _ in return nil }
            .eraseToAnyPublisher()
    }
}

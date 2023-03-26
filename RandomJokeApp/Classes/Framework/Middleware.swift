//
//  Middleware.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

protocol Middleware<State, Action> {
    associatedtype State
    associatedtype Action
    
    func handle(action: Action, in state: State) -> any Effect<Action>
}

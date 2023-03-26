//
//  Reducer.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 26.03.23.
//

protocol Reducer<State, Action> {
    associatedtype State
    associatedtype Action
    
    func reduce(state: inout State, action: Action)
}

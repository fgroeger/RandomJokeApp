//
//  RandomJokeDTO.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

struct RandomJokeDTO: Decodable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}

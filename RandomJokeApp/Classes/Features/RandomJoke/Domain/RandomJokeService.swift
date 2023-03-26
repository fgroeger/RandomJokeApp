//
//  RandomJokeService.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

import Combine

final class RandomJokeService {
    static let shared = RandomJokeService(repository: .shared)
    
    var randomJokePublisher: AnyPublisher<RandomJoke, Never> {
        repository.randomJokePublisher
            .map { dto in
                RandomJoke(id: dto.id, setup: dto.setup, punchline: dto.punchline)
            }
            .eraseToAnyPublisher()
    }
    
    private let repository: RandomJokeRepository
    
    init(repository: RandomJokeRepository) {
        self.repository = repository
    }
    
    func refreshRandomJoke() {
        repository.refreshRandomJoke()
    }
}

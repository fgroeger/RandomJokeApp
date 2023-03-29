//
//  RandomJokeService.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

import Combine

final class RandomJokeService {
    static let shared = RandomJokeService(repository: .shared)
    
    var randomJokePublisher: AnyPublisher<Result<RandomJoke, Error>, Never> {
        repository.randomJokePublisher
            .map { dtoResult in
                switch dtoResult {
                    case let .success(dto):
                        let joke = RandomJoke(id: dto.id, setup: dto.setup, punchline: dto.punchline)
                        return .success(joke)
                        
                    case let .failure(error):
                        return .failure(error)
                }
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

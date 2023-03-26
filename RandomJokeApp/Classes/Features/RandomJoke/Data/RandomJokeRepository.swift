//
//  RandomJokeRepository.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

import Combine
import Foundation

final class RandomJokeRepository {
    static let shared = RandomJokeRepository()
    
    var randomJokePublisher: AnyPublisher<RandomJokeDTO, Never> {
        $randomJoke
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    @Published private var randomJoke: RandomJokeDTO?
    
    func refreshRandomJoke() {
        Task {
            let url = URL(string: "https://official-joke-api.appspot.com/random_joke")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let joke = try JSONDecoder().decode(RandomJokeDTO.self, from: data)
            
            self.randomJoke = joke
        }
    }
}

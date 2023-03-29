//
//  RandomJokeView.swift
//  RandomJokeApp
//
//  Created by Fabian Gröger on 09.03.23.
//

import SwiftUI

struct RandomJokeView: View {
    @ObservedObject private var store = RandomJokeStoreFactory().createStore()
    
    var body: some View {
        ZStack {
            Color(
                hue: store.state.hue,
                saturation: 0.1,
                brightness: 0.4
            )
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut, value: store.state.hue)
            
            VStack(spacing: 16) {
                switch store.state.currentJoke {
                    case .loading:
                        loadingView()
                        
                    case let .joke(joke):
                        jokeView(joke)
                        
                    case .error:
                        jokeErrorView()
                }
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    store.dispatch(.favorite)
                } label: {
                    if case let .joke(joke) = store.state.currentJoke,
                       joke.isFavorite {
                        Image(systemName: "heart.fill")
                            .tint(.red)
                    } else {
                        Image(systemName: "heart")
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    store.dispatch(.refreshJoke)
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .onAppear {
            store.dispatch(.onAppear)
            store.dispatch(.refreshJoke)
        }
    }
    
    @ViewBuilder func loadingView() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
    
    @ViewBuilder func jokeView(_ joke: RandomJokeState.CurrentJoke.Joke) -> some View {
        Text(joke.setup)
            .font(.title)
            .shadow(radius: 1)
            .foregroundColor(.white)
        
        HStack {
            Spacer()
            
            Text(joke.punchline)
                .font(.body)
                .shadow(radius: 1)
                .foregroundColor(.white)
        }
    }
    
    @ViewBuilder func jokeErrorView() -> some View {
        Text("Oops, something went wrong! Please try again.")
            .font(.title)
            .shadow(radius: 1)
            .foregroundColor(.white)
    }
}

struct RandomJokeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomJokeView()
    }
}

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
                Text(store.state.setup)
                    .font(.title)
                    .shadow(radius: 1)
                    .foregroundColor(.white)
                    .animation(.easeInOut, value: store.state.setup)
                
                HStack {
                    Spacer()
                    
                    Text(store.state.punchline)
                        .font(.body)
                        .shadow(radius: 1)
                        .foregroundColor(.white)
                        .animation(.easeInOut, value: store.state.punchline)
                }
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    store.dispatch(.favorite)
                } label: {
                    if store.state.isFavorite {
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
}

struct RandomJokeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomJokeView()
    }
}

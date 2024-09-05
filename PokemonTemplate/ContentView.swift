//
//  ContentView.swift
//  PokemonTemplate
//
//  Created by Mark Kinoshita on 8/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var apiManager = APIManager()
    @State private var searchText = ""
    @State private var selectedPokemonDetails: PokemonDetailResponse?

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search Pokémon", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .onChange(of: searchText) {
                        apiManager.searchPokemon(query: searchText)
                    }
                
                if !searchText.isEmpty {
                    // List of searched Pokémon
                    List(apiManager.searchedPokemon, id: \.name) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: apiManager.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: []))
                        ) {
                            Text(pokemon.name.capitalized)
                        }
                        .onTapGesture {
                            apiManager.fetchPokemonDetails(for: pokemon.url)
                        }
                    }
                } else {
                    // List of Pokémon
                    List(apiManager.pokemons, id: \.url) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: apiManager.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: []))
                        ) {
                            Text(pokemon.name.capitalized)
                        }
                        .onTapGesture {
                            apiManager.fetchPokemonDetails(for: pokemon.url)
                        }
                    }
                    .onAppear {
                        apiManager.fetchPokemons()
                    }
                    .navigationTitle("Pokémon List")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

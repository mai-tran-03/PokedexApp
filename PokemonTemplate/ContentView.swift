//
//  ContentView.swift
//  PokemonTemplate
//
//  Created by Mark Kinoshita on 8/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search Pokémon", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .onChange(of: searchText) {
                        viewModel.searchPokemon(query: searchText)
                    }
                
                if !searchText.isEmpty {
                    // List of searched Pokémon
                    List(viewModel.searchedPokemon, id: \.name) { pokemon in
                        NavigationLink(pokemon.name.capitalized, value: pokemon)
                    }
                    .navigationDestination(for: PokemonEntry.self) { selectedPokemon in
                        PokemonDetailView(pokemon: viewModel.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: []))
                        
                        .onAppear {
                            viewModel.fetchPokemonDetails(for: selectedPokemon.url)
                        }
                        .navigationTitle(selectedPokemon.name.capitalized)
                    }
                } else {
                    // List of Pokémon
                    List(viewModel.pokemons, id: \.url) { pokemon in
                        NavigationLink(pokemon.name.capitalized, value: pokemon)
                        
                        .onAppear {
                            if pokemon == viewModel.pokemons.last {
                                viewModel.loadMorePokemons()
                            }
                        }
                    }
                    .navigationDestination(for: PokemonEntry.self) { selectedPokemon in
                        PokemonDetailView(pokemon: viewModel.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: []))
                        
                        .onAppear {
                            viewModel.fetchPokemonDetails(for: selectedPokemon.url)
                        }
                        .navigationTitle(selectedPokemon.name.capitalized)
                    }
                    .navigationTitle("Pokémon List")
                
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

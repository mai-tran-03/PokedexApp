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
        NavigationView {
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
                        NavigationLink(destination: PokemonDetailView(pokemon: viewModel.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: []))
                        ) {
                            Text(pokemon.name.capitalized)
                        }
                        .onTapGesture {
                            viewModel.fetchPokemonDetails(for: pokemon.url)
                        }
                    }
                } 
                else {
                    // List of Pokémon
                    List(viewModel.pokemons, id: \.url) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: viewModel.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: []))
                        ) {
                            Text(pokemon.name.capitalized)
                        }
                        .onAppear {
                            if pokemon == viewModel.pokemons.last {
                                viewModel.loadMorePokemons()
                            }
                        }
                        .onTapGesture {
                            viewModel.fetchPokemonDetails(for: pokemon.url)
                        }
                    }
                    .onAppear() {
                        if viewModel.pokemons.isEmpty {
                            viewModel.fetchPokemons()
                        }
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

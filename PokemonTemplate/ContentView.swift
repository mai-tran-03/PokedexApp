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
//    @State private var pokemonImage = ""
    
    var searchedPokemon: [PokemonEntry] {
        if searchText.isEmpty {
            return viewModel.pokemons
        } else {
            return viewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased())}
        }
    }

    var body: some View {
        NavigationStack {
//            List(viewModel.pokemons) { pokemon in
//                NavigationLink {
//                    PokemonDetailView(pokemon: viewModel.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: [], sprites: PokemonDetailResponse.defaultSprites, types: []))
//                } label: {
//                    PokemonRow(pokemon: pokemon, pokemonImage: )
//                    }
//                }
            List {
                ForEach(searchedPokemon, id: \.id) { pokemon in
                    NavigationLink(pokemon.name.capitalized, value: pokemon)
                        .onAppear {
                            if pokemon == viewModel.pokemons.last {
                                viewModel.loadMorePokemons()
                            }
                        }
                }
            }
            .navigationDestination(for: PokemonEntry.self) { selectedPokemon in
                PokemonDetailView(pokemon: viewModel.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: [], sprites: PokemonDetailResponse.defaultSprites, types: []))
                    .onAppear {
                        viewModel.fetchPokemonDetails(for: selectedPokemon.url)
                    }
            }
            .navigationTitle("Pokémon List")
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
        .searchable(text: $searchText, prompt: "Search for Pokémon")
    }
}

#Preview {
    ContentView()
}

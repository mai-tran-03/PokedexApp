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
    
    var searchedPokemon: [PokemonEntry] {
        if searchText.isEmpty {
            return viewModel.pokemons
        } else {
            return viewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased())}
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchedPokemon, id: \.id) { pokemon in
                    NavigationLink(value: pokemon) {
                        HStack {
                            if let sprites = viewModel.pokemonSprites[pokemon.url] {
                                PokemonRow(pokemon: pokemon, imageURL: sprites.front_default)
                            } else {
                                PokemonRow(pokemon: pokemon, imageURL: nil)
                                    .onAppear {
                                        fetchSprites(for: pokemon)
                                    }
                            }
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
    
    private func fetchSprites(for pokemon: PokemonEntry) {
        viewModel.fetchPokemonSprites(for: pokemon.url) { sprites in
            if let sprites = sprites {
                DispatchQueue.main.async {
                    viewModel.pokemonSprites[pokemon.url] = sprites
                }
            } else {
                print("No details found for \(pokemon.name)")
            }
        }
    }
}

#Preview {
    ContentView()
}

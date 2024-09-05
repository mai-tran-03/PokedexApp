//
//  ContentView.swift
//  PokemonTemplate
//
//  Created by Mark Kinoshita on 8/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var apiManager = APIManager()

    var body: some View {
        NavigationView {
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

#Preview {
    ContentView()
}

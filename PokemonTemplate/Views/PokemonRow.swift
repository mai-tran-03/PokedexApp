//
//  PokemonRow.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/13/24.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: PokemonEntry
    var pokemonImage: PokemonDetailResponse.Sprites
    
    var body: some View {
        HStack {
            PokemonImageView(imageURLString: pokemonImage.front_default)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Text(pokemon.name.capitalized)
        }
//        .onAppear {
//            viewModel.fetchPokemonSprites(for: pokemon.url) { sprites in
//                if let front_default = sprites.front_default {
//                    pokemonImage = front_default
//                } else {
//                    pokemonImage = Image(systemName: "xmark.circle")
//                }
//            }
//        }
    }
}

#Preview {
    PokemonRow(
        pokemon: PokemonEntry(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
        pokemonImage: PokemonDetailResponse.Sprites.init(
            front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", 
            other: PokemonDetailResponse.Sprites.OtherSprites(
                official_artwork: PokemonDetailResponse.Sprites.OtherSprites.OfficialArtwork(
                    front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
                )
            )
        )
    )
}

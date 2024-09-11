//
//  PokemonDetailView.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/4/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonDetailResponse

    var body: some View {
        VStack {
            Text("\(pokemon.name.capitalized)")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Spacer()
            
            if let frontSpriteURL = URL(string: pokemon.sprites.other.official_artwork.front_default) {
                AsyncImage(url: frontSpriteURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                .padding(.top, 20)
            }
            
            Spacer()
            
            VStack (alignment: .leading, spacing: 10) {
                detailRow(name: "Height", value: "\(pokemon.height)")
                detailRow(name: "Weight", value: "\(pokemon.weight)")
                
                VStack (alignment: .leading) {
                    Text("Abilities")
                        .font(.headline)
                    ForEach(pokemon.abilities, id: \.ability.name) { detail in
//                        HStack { 
                            Text(detail.ability.name.capitalized)
//                            Spacer()
//                            Text("Some other details")
//                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 10)
            
            Spacer()
        }
    .padding()
    }
    
    @ViewBuilder
    private func detailRow(name: String, value: String) -> some View {
        HStack {
            Text(name)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.body)
        }
    }
}

#Preview {
    PokemonDetailView(
        pokemon: PokemonDetailResponse(
            name: "bulbasaur",
            height: 7,
            weight: 69,
            abilities: [
                PokemonDetailResponse.Ability(ability: PokemonDetailResponse.Ability.AbilityDetail(name: "overgrow")),
                PokemonDetailResponse.Ability(ability: PokemonDetailResponse.Ability.AbilityDetail(name: "chlorophyll"))
            ],
            sprites: PokemonDetailResponse.Sprites(
                front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                other: PokemonDetailResponse.Sprites.OtherSprites(
                    official_artwork: PokemonDetailResponse.Sprites.OtherSprites.OfficialArtwork(
                        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
                    )
                )
            )
        )
    )
}

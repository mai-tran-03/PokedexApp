//
//  PokemonDetailView.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/4/24.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonDetailResponse
    
    @State private var selectedAbility: PokemonDetailResponse.Ability?

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
            
            HStack {
                ForEach(pokemon.types, id: \.type.name) { detail in
                    Text(detail.type.name.capitalized)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            
            Spacer()

            VStack (alignment: .leading, spacing: 10) {
                detailRow(name: "Height", value: "\(pokemon.height)")
                detailRow(name: "Weight", value: "\(pokemon.weight)")
                Text("Abilities")
                    .font(.headline)
            }
            
            ZStack {
                VStack (alignment: .leading, spacing: 10) {
                    HStack {
                        ForEach(pokemon.abilities, id: \.ability.name) { detail in
                            Button(action: {
                                withAnimation {
                                    selectedAbility = detail
                                }
                            }) {
                                Text(detail.ability.name.capitalized)
                                    .padding(5)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    if let ability = selectedAbility {
                        AbilityHoverView(ability: ability, closeAction: {
                            withAnimation {
                                selectedAbility = nil
                            }
                        })
                    }
                }
            }
//            .padding(.top, 20)
//            .padding(.horizontal, 10)
            
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

struct AbilityHoverView: View {
    let ability: PokemonDetailResponse.Ability
    let closeAction: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Effects")
                    .font(.headline)
                Spacer()
                Button(action: closeAction) {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.bottom, 15)
                }
            }
            
            Text("Details about \(ability.ability.name) will go here.")
            
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 250)
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
            ),
            types: [
                PokemonDetailResponse.Element(type: PokemonDetailResponse.Element.ElementDetail(name: "grass")),
                PokemonDetailResponse.Element(type: PokemonDetailResponse.Element.ElementDetail(name: "poison"))
            ]
        )
    )
}

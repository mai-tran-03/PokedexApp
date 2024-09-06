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
        Form {
            Section(header: Text("Details")) {
                Text("**Height:** \(pokemon.height)")
                Text("**Weight:** \(pokemon.weight)")

                HStack() {
                    Text("**Abilities:**")
                        .font(.headline)
                    ForEach(pokemon.abilities, id: \.ability.name) { detail in
                        Text(detail.ability.name.capitalized)
                    }
                }
            }
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}

#Preview {
    PokemonDetailView(
        pokemon: PokemonDetailResponse(
            name: "pikachu",
            height: 4,
            weight: 60,
            abilities: [
                PokemonDetailResponse.Ability(ability: PokemonDetailResponse.Ability.AbilityDetail(name: "static")),
                PokemonDetailResponse.Ability(ability: PokemonDetailResponse.Ability.AbilityDetail(name: "lightning-rod"))
            ])
    )
}

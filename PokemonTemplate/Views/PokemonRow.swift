//
//  PokemonRow.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/13/24.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: PokemonEntry
    var imageURL: String?
    
    var body: some View {
        HStack {
            if let imageURL = imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "questionmark").resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            Text(pokemon.name.capitalized)
        }
    }
}

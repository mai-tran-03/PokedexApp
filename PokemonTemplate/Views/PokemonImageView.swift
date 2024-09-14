//
//  PokemonImageView.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/12/24.
//

import SwiftUI

struct PokemonImageView: View {
    let imageURLString: String?
    
    var body: some View {
        if let imageURLString = imageURLString, let imageURL = URL(string: imageURLString) {
            AsyncImage(url: imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: "photo")
        }
    }
}

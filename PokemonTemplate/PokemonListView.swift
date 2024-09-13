////
////  PokemonListView.swift
////  PokemonTemplate
////
////  Created by Mai Tran on 9/11/24.
////
//
//import SwiftUI
//
//struct PokemonListView: View {
//    @ObservedObject var viewModel: PokemonViewModel
//    let searchText: String
//    
//    var body: some View {
//        List(viewModel.pokemons, id: \.name) { pokemon in
//            NavigationLink(pokemon.name.capitalized, value: pokemon)
//                .onAppear {
//                    if pokemon == viewModel.pokemons.last && searchText.isEmpty {
//                        viewModel.loadMorePokemons()
//                    }
//                }
//        }
//    }
//}
//
//extension PokemonViewModel {
//    searchText.isEmpty ? pokemons : searchedPokemon
//}
////#Preview {
////    PokemonListView()
////}

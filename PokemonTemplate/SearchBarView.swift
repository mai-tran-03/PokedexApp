////
////  SearchBarView.swift
////  PokemonTemplate
////
////  Created by Mai Tran on 9/11/24.
////
//
//import SwiftUI
//
//struct SearchBarView: View {
//    @ObservedObject var viewModel: PokemonViewModel
//    @State private var searchText = ""
////    @Binding var searchText: String
////    var onSearch: (String) -> Void
////    
//    var body: some View {
////        TextField("Search Pokémon", text: $searchText)
////            .padding()
////            .background(Color(.systemGray6))
////            .cornerRadius(10)
////            .padding(.horizontal)
////            .onChange(of: searchText) {
////                viewModel.searchPokemon(query: searchText)
////            }
//        
//        NavigationStack {
//            List {
//                ForEach(searchedPokemon, id: \.name) { pokemon in
//                    NavigationLink(pokemon.name.capitalized, value: pokemon)
//                }
//            }
//            .searchable(text: $viewModel.searchText)
////            .onChange(of: viewModel.searchText) {
////                 viewModel.searchPokemon(query: searchText)
////            }
//            .navigationDestination(for: PokemonEntry.self) { selectedPokemon in
//                PokemonDetailView(pokemon: viewModel.selectedPokemonDetail ?? PokemonDetailResponse(name: "", height: 0, weight: 0, abilities: [], sprites: PokemonDetailResponse.defaultSprites, types: []))
//                
//                    .onAppear {
//                        viewModel.fetchPokemonDetails(for: selectedPokemon.url)
//                    }
//                
//            }
//        }
//    }
//    
//    var searchedPokemon: [PokemonEntry] {
//        if searchText.isEmpty {
//            return viewModel.pokemons
//        } else {
//            return viewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased())}
//        }
//    }
//}
//
////extension PokemonViewModel {
////    static func mock() -> PokemonViewModel {
////        let viewModel = PokemonViewModel()
////        searchText = "Bulbasaur"
////        return viewModel
////    }
////}
////
////#Preview {
////    SearchBarView(viewModel: PokemonViewModel.mock())
////}

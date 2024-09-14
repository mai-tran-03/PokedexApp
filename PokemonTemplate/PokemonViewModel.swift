//
//  PokemonViewModel.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/4/24.
//

import SwiftUI
import Combine

/*
 Manage state of the application's data relating to the user interface
 Manipulate data (e.g. filtering, sorting)
 */
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [PokemonEntry] = []
    @Published var selectedPokemonDetail: PokemonDetailResponse?
    @Published var pokemonSprites: [String: PokemonDetailResponse.Sprites] = [:]
    @Published var isLoading: Bool = false
    
    private var apiManager = APIManager()
    
    init() {
        fetchPokemons()
    }
    
    func fetchPokemons(offset: Int = 0) {
        guard !isLoading else { return }
        isLoading = true
        
        apiManager.fetchPokemons(offset: offset) { [weak self] newPokemons in
            DispatchQueue.main.async {
                if offset == 0 {
                    self?.pokemons = newPokemons
                } else {
                    self?.pokemons.append(contentsOf: newPokemons)
                }
                self?.isLoading = false
            }
        }
    }
    
    func loadMorePokemons() {
        if !isLoading {
            fetchPokemons(offset: pokemons.count)
        }
    }
    
    func fetchPokemonDetails(for url: String) {
        apiManager.fetchPokemonDetails(for: url) { [weak self] detail in
            DispatchQueue.main.async {
                self?.selectedPokemonDetail = detail
            }
        }
    }
    
    func fetchPokemonSprites(for url: String, completion: @escaping (PokemonDetailResponse.Sprites?) -> Void) {
        apiManager.fetchPokemonDetails(for: url) { detail in
            DispatchQueue.main.async {
                if let sprites = detail?.sprites {
                    self.pokemonSprites[url] = sprites
                    completion(detail?.sprites)
                } else {
                    completion(nil)
                }
            }
        }
    }
}

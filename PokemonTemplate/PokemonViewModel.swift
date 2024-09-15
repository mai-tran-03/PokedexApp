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
//    @Published var selectedAbilityDetail: AbilityDetailResponse?
//    @Published var selectedAbilityEffect: String = ""
    
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
    
    func fetchPokemonSprites(for url: String) {
        if pokemonSprites[url] != nil { return }
        
        apiManager.fetchPokemonDetails(for: url) { detail in
            DispatchQueue.main.async {
                if let sprites = detail?.sprites {
                    // Store fetched sprites in dictionary using pokemon's URL as key
                    self.pokemonSprites[url] = sprites
                } else {
                    print("No details found for URL: \(url)")
                }
            }
        }
    }
    
//    func fetchAbilityDetails(for ability: PokemonDetailResponse.Ability, language: String) {
//        apiManager.fetchAbilityDetails(from: ability.ability.url) { [weak self] detail in
//            DispatchQueue.main.async {
//                if let effect = detail?.effect_entries.first(where: { $0.language.name == language })?.effect {
//                    self?.selectedAbilityEffect = effect
//                } else {
//                    self?.selectedAbilityEffect  = "Effect not available in \(language)"
//                }
//                
//            }
//        }
//    }
}

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
    @Published var searchedPokemon: [PokemonEntry] = []
    @Published var isLoading: Bool = false
    
    private var apiManager = APIManager()
//    private var currentPage = 0
//    private var cancellables = Set<AnyCancellable>()
    private var searchDebounceTimer: AnyCancellable? = nil
    
    init() {
        fetchPokemons()
    }
    
    func fetchPokemons(offset: Int = 0) {
        print("In viewModel, fetchPokemons called *********************")
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
        print("In viewModel, loadMorePokemons called **********")
        if !isLoading {
            fetchPokemons(offset: pokemons.count)
        }
    }
    
    func fetchPokemonDetails(for url: String) {
        print("In viewModel, fetchPokemonDetails called")
        apiManager.fetchPokemonDetails(for: url) { [weak self] detail in
            DispatchQueue.main.async {
                self?.selectedPokemonDetail = detail
            }
        }
    }
    
    func debouncedSearch(query: String) {
        print("In viewModel, debouncedSearch called ************************")
        searchDebounceTimer?.cancel()
        
        searchDebounceTimer = Just(query)
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] newQuery in
                self?.searchPokemon(query: newQuery)
            }
    }
    
    func searchPokemon(query: String) {
        print("In viewModel, searchPokemon called ----- \(query)")
        if query.isEmpty {
            fetchPokemons()
        } else {
            searchedPokemon = pokemons.filter { $0.name.lowercased().contains(query.lowercased())
            }
        }
        print("Searched Pokémon count: \(pokemons.count)")
    }
}

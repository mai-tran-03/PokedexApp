//
//  APIManager.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/4/24.
//

import Foundation

class APIManager: ObservableObject {
    // Base URL for the Pokémon API
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    // Observable list of Pokémon names
    @Published var pokemons: [PokemonEntry] = []
    @Published var selectedPokemonDetail: PokemonDetailResponse?
    @Published var searchedPokemon: [PokemonEntry] = []

    // Fetch list of Pokémon
    func fetchPokemons() {
        guard let url = URL(string: "\(baseURL)?limit=20") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Parsing the JSON data
            do {
                let jsonData = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.pokemons = jsonData.results
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // Fetch details of Pokémon
    func fetchPokemonDetails(for url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Parsing the JSON data
            do {
                let jsonData = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.selectedPokemonDetail = jsonData
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // Filter Pokémon by name
    func searchPokemon(query: String) {
        if query.isEmpty {
            searchedPokemon = pokemons
        } else {
            searchedPokemon = pokemons.filter { $0.name.lowercased().contains(query.lowercased())
            }
        }
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable {
    let name: String
    let url: String
    var id: String { name }
}

struct PokemonDetailResponse: Codable {
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Ability]

    struct Ability: Codable {
        let ability: AbilityDetail

        struct AbilityDetail: Codable {
            let name: String
//            let url: String
        }
    }
}

//
//  APIManager.swift
//  PokemonTemplate
//
//  Created by Mai Tran on 9/4/24.
//

import Foundation

/*
 Handle network requests and interacting with the API
 Fetch data from the server and decode responses
 */
class APIManager: ObservableObject {
    // Base URL for the Pokémon API
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    // Observable list of Pokémon names and Pokemon details
    @Published var pokemons: [PokemonEntry] = []
    @Published var selectedPokemonDetail: PokemonDetailResponse?
    
    // Fetch list of Pokémon
    func fetchPokemons(offset: Int = 0, completion: @escaping ([PokemonEntry]) -> Void) {
        let limit = 20
        
        guard let url = URL(string: "\(baseURL)?limit=\(limit)&offset=\(offset)") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Parsing the JSON data
            do {
                let jsonData = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(jsonData.results)
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // Fetch details of Pokémon
    func fetchPokemonDetails(for url: String, completion: @escaping (PokemonDetailResponse?) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Parsing the JSON data
            do {
                let jsonData = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable, Equatable {
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
        }
    }
}

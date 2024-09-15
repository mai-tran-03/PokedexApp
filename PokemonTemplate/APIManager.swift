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
    
    // Fetch ability details of Pokemon
    func fetchAbilityDetails(from url: String, completion: @escaping (AbilityDetailResponse?) -> Void) {
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
                let jsonData = try JSONDecoder().decode(AbilityDetailResponse.self, from: data)
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

struct PokemonEntry: Codable, Identifiable, Hashable {
    let name: String
    let url: String
    var id: String { name }
    var sprites: PokemonDetailResponse.Sprites?
}

struct PokemonDetailResponse: Codable, Hashable {
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Ability]
    let sprites: Sprites
    let types: [Element]

    struct Ability: Codable, Hashable {
        let ability: AbilityDetail

        struct AbilityDetail: Codable, Hashable {
            let name: String
            let url: String
        }
    }
    
    struct Sprites: Codable, Hashable {
        let front_default: String?
        let other: OtherSprites?
        
        struct OtherSprites: Codable, Hashable {
            let official_artwork: OfficialArtwork?
            
            struct OfficialArtwork: Codable, Hashable {
                let front_default: String?
            }
            
            enum CodingKeys: String, CodingKey {
                case official_artwork = "official-artwork"
            }
        }
    }
    
    struct Element: Codable, Hashable {
        let type: ElementDetail
        
        struct ElementDetail: Codable, Hashable {
            let name: String
        }
    }
    
    static let defaultSprites = Sprites(
        front_default: "",
        other: Sprites.OtherSprites(
            official_artwork: Sprites.OtherSprites.OfficialArtwork(front_default: "")
        )
    )
}

struct AbilityDetailResponse: Codable, Hashable {
    let name: String
    let effect_entries: [Effect]
    
    struct Effect: Codable, Hashable {
        let effect: String
        let language: NamedAPIResource
    }
    
    struct NamedAPIResource: Codable, Hashable {
        let name: String
    }
}

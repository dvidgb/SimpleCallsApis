//
//  ViewModel.swift
//  PokeApiCallForm
//
//  Created by David Bueno Castro on 1/5/23.
//

import Foundation

struct PokemonDataModel: Decodable {
    let name: String
    let url: String
}

struct PokemonResponseDataModel: Decodable {
    let pokemons: [PokemonDataModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results)
    }
    
    //call to api
    
    final class ViewModel {
        
        func getPokemons() {
            let url =  URL(string: "")
            
            URLSession.shared.dataTask(with: url!) { data, response, error in
                
                if let _  =  error {
                    print("Error")
                }
                
                if let data = data,
                   let httpResponse =  response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    let pokemonDataModel =  try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
                    print("Pokemons \(pokemonDataModel)")
                }
            }.resume()
        }
    }
}

//
//  CharacterData.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


class CharacterData: Codable {
    var name: String = ""
    var birthYear: String = ""
    var gender: String = ""
    var homeworldURL: String = ""
    var speciesURL: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case gender
        case homeworldURL = "homeworld"
        case speciesURL = "species"
    }
    
    
    var homeworld: PlanetData?
    
    func fetchHomeworld(completion: @escaping () -> Void) {
        guard let url = URL(string: self.homeworldURL) else {
            completion()
            return
        }
        let planetTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let planetData = data {
                    let planetInfo = try JSONDecoder().decode(PlanetData.self, from: planetData)
                    print(planetInfo.name)
                    self.homeworld = planetInfo
                }
            } catch {
                print(error)
            }
            completion()
        }
        planetTask.resume()

    }
    
    
    
    
    var species: SpeciesData?

    func fetchSpecies(completion: @escaping () -> Void) {
        guard let url = URL(string: self.speciesURL[0]) else {
            completion()
            return
        }
        let speciesTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let speciesData = data {
                    let speciesInfo = try JSONDecoder().decode(SpeciesData.self, from: speciesData)
                    print(speciesInfo.name)
                    self.species = speciesInfo
                }
            } catch {
                print(error)
            }
            completion()
        }
        speciesTask.resume()

    }

    
    
    
    
}





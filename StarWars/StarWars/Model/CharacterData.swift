//
//  CharacterData.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation

///class set default values,
struct CharacterData: Codable {
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
    var species: SpeciesData?
    
}





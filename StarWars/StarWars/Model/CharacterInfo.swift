//
//  CharacterInfo.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation

class CharacterInfo: Codable {
    
    var name: String
    var birth_year: String
    var gender: String
    var homeworld: String
    var species: [String]
    
    
    /*
    
    
    
    var nameDescription: String {
        return "Name: \(name)"
    }
    
    var birthYearDescription: String {
        return "Birth Year: \(birth_year)"
    }
    
    var genderDescription: String {
        return "Gender: \(gender)"
    }
    
    var homeworldDescription: String {
        return "Homeworld: \(homeworld)"
    }
    
    var speciesDescription: String {
        return "Species: \(species[0])"
    }
 
 */
}

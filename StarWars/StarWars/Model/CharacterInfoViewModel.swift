//
//  CharacterInfoViewModel.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


class CharacterInfoViewModel {
    
    var name: String
    var birth_year: String
    var gender: String
    var homeworld: String
    var species: [String] = [""]
    
    
    init(model: CharacterInfo) {
        var nameDescription = model.name
        self.name = "Name: \(nameDescription)"
        
        var birthYearDescription = model.birth_year
        self.birth_year = "Year of Birth: \(birthYearDescription)"
        
        var genderDescription = model.gender
        self.gender = "Gender: \(genderDescription)"
        
        var homeworldDescription = model.homeworld
        self.homeworld = "Homeworld: \(homeworldDescription)"
        
//        var speciesDescription = model.species
//        self.species = ["Species: \(speciesDescription[0])"]
        
        var speciesDescription: String {
            return "Species: \(species[0])"
        }
    }
    
}

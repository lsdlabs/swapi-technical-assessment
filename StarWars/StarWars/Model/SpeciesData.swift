//
//  SpeciesData.swift
//  StarWars
//
//  Created by Lauren Small on 10/29/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


struct SpeciesData: Codable {
    let name: String
    let classification: String
    let designation: String
    let average_height: String
    let skin_colors: String
    let hair_colors: String
    let eye_colors: String
    let average_lifespan: String
    let homeworld: String
    let language: String
    let people: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
    
}





/*
 //
 //  SpeciesData.swift
 //  StarWars
 //
 //  Created by Lauren Small on 10/29/18.
 //  Copyright © 2018 Lauren Small. All rights reserved.
 //
 
 import Foundation
 
 
 struct SpeciesData: Codable {
 var name: String = ""
 var classification: String = ""
 var designation: String = ""
 var average_height = ""
 var skin_colors = ""
 var hair_colors = ""
 var eye_colors = ""
 var average_lifespan = ""
 var homeworld = ""
 var language =  ""
 var people: [String] = []
 var films: [String] = []
 var created = ""
 var edited = ""
 var url = ""
 
 }

 */

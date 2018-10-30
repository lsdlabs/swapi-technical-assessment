//
//  SpeciesData.swift
//  StarWars
//
//  Created by Lauren Small on 10/29/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


class SpeciesData: Codable {
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

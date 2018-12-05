//
//  PlanetData.swift
//  StarWars
//
//  Created by Lauren Small on 10/29/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


struct PlanetData: Codable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let residents: [URL]
    let films: [String]
    
}




/*
//
//  PlanetData.swift
//  StarWars
//
//  Created by Lauren Small on 10/29/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


struct PlanetData: Codable {
    var name: String = ""
    var rotation_period: String = ""
    var orbital_period: String = ""
    var diameter = ""
    var climate = ""
    var gravity = ""
    var terrain = ""
    var surface_water = ""
    var population = ""
    var residents: [URL] = []
    var films: [String] = []
    
}
*/

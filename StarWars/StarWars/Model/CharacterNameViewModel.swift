//
//  CharacterNameViewModel.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


class CharacterNameViewModel: Codable {
    var name: String
    
    
    init(model: CharacterName) {
        var character = model.name
        self.name = "\(character)"
    }
}

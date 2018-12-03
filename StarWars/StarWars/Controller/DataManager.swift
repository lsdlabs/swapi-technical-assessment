//
//  DataManager.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation


class DataManager {
    
    static let instance = DataManager()
    
    
    let filmURL = "https://swapi.co/api/films/2/"
    var characterArray = [CharacterData]()
    let characterDataInstance = CharacterData()
    
    
    func fetchCharacters(completion: @escaping () -> Void ) {
        
        let task = URLSession.shared.dataTask(with: URL(string: self.filmURL)!) { (data, response, error) in
            if let actualData = data {
                do {
                    let filmInfo = try JSONDecoder().decode(FilmInfo.self, from: actualData)
                    let queue = DispatchQueue(label: "characterQueue")
                    let parseQueue = DispatchQueue(label: "serializationQueue")
                    for url in filmInfo.characters {
                        queue.suspend()
                        let characterTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                            do {
                                if let characterData = data {
                                    let characterInfo = try JSONDecoder().decode(CharacterData.self, from: characterData)
                                    print(characterInfo.name)
                                    parseQueue.async {
                                        
                                        
                                        self.characterArray.append(characterInfo)
                                        queue.resume()
                                    }
                                }
                            } catch {
                                print(error)
                            }
                        }
                        characterTask.resume()
                    }
                    queue.async {
                        completion()
                    }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    
    var homeworld: PlanetData?
    
    func fetchHomeworld(completion: @escaping () -> Void) {
        guard let url = URL(string: characterDataInstance.homeworldURL) else {
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
        guard let url = URL(string: characterDataInstance.speciesURL[0]) else {
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





























struct FilmInfo: Codable {
    var characters: [URL]
}

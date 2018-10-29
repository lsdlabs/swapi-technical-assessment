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
    
}

struct FilmInfo: Codable {
    var characters: [URL]
}

//
//  CharacterListViewController.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import UIKit

class CharacterListViewController: UITableViewController {
    
    let filmURL = "https://swapi.co/api/films/2/"
    var characterArray = [CharacterData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Star Wars Ep. V Characters"
        self.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        fetchCharacters {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Escaping closure executed after body of function
    // Data task fetches URL...trailing closure
    // Accepts two arguments (URL and completion block)
    func fetchCharacters(completion: @escaping () -> Void ) {
        let task = URLSession.shared.dataTask(with: URL(string: self.filmURL)!) { (data, response, error) in
            if let actualData = data {//2.Codable is a throwing function
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
    
    // MARK: TableView Delegate & Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        cell.character = characterArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CharacterDetailsTableViewController(character: characterArray[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

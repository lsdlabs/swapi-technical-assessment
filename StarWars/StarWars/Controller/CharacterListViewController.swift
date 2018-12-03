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
    var characterData: CharacterData?
    
    var homeworld: PlanetData?
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Characters in The Empire Strikes Back"
//        self.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
//        // Do any additional setup after loading the view.
//        DataManager.instance.fetchCharacters {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters in The Empire Strikes Back"
        self.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        // Do any additional setup after loading the view.
        fetchCharacters() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
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
    
    
    /*
    func parse(data: Data) -> CharacterData? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(CharacterData.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
    */
    
    
    //var homeworld: PlanetData?
    
    func fetchHomeworld(completion: @escaping () -> Void) {
        
        guard let characterHomeworldURL = characterData?.homeworldURL else {
            return
        }
        guard let url = URL(string: characterHomeworldURL) else {
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
    
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.characterArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        cell.character = DataManager.instance.characterArray[indexPath.row]
        return cell
    }
    
    
    
////////////////ORIGINAL///////////////////////////////////////////////////////////////////
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = CharacterDetailsTableViewController(character: DataManager.instance.characterArray[indexPath.row])
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
//////////////////////////////////////////////////////////////////////////////////////////
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = CharacterDetailsTableViewController(character: DataManager.characterDataInstance.characterArray[indexPath.row])
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = CharacterDetailsTableViewController(character: DataManager.characterArray[indexPath.row])
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = CharacterDetailsTableViewController(character: DataManager[indexPath.row])
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = CharacterDetailsTableViewController(character: DataManager)
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = CharacterDetailsTableViewController(character: DataManager.instance.characterArray[indexPath.row])
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
}



//
//  CharacterDetailsTableViewController.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import UIKit

class CharacterDetailsTableViewController: UITableViewController {
    var character: CharacterData?
    
    enum CharacterField: Int { case name, birthyear, gender, homeworld, species, count }
    
    convenience init(character: CharacterData) {
        self.init(nibName: "CharacterDetailsTableViewController", bundle: nil)
        self.character = character
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.character?.name
        
        if self.character?.homeworld == nil {
            self.fetchHomeworld {
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
        
        if self.character?.species == nil {
            self.fetchSpecies {
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func fetchHomeworld(completion: @escaping () -> Void) {
        guard let url = URL(string: character!.homeworldURL) else {
            completion()
            return
        }
        let planetTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let planetData = data {
                    let planetInfo = try JSONDecoder().decode(PlanetData.self, from: planetData)
                    print(planetInfo.name)
                    self.character!.homeworld = planetInfo
                }
            } catch {
                print(error)
            }
            completion()
        }
        planetTask.resume()
        
    }
    
    func fetchSpecies(completion: @escaping () -> Void) {
        guard let url = URL(string: character!.speciesURL[0]) else {
            completion()
            return
        }
        let speciesTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let speciesData = data {
                    let speciesInfo = try JSONDecoder().decode(SpeciesData.self, from: speciesData)
                    print(speciesInfo.name)
                    self.character!.species = speciesInfo
                }
            } catch {
                print(error)
            }
            completion()
        }
        speciesTask.resume()
        
    }
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CharacterField.count.rawValue
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")

        let field = CharacterField(rawValue: indexPath.row) ?? .name
        switch field {
        case .name:
            cell.textLabel?.text = self.character?.name

        case .birthyear:
            cell.textLabel?.text = self.character?.birthYear

        case .gender:
            cell.textLabel?.text = self.character?.gender
            
        case .homeworld:
            cell.textLabel?.text = self.character?.homeworld?.name ?? "…"

        case .species:
            cell.textLabel?.text = self.character?.species?.name ?? "…"
            
        default: break
        }

        // Configure the cell...

        return cell
    }
}

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
 //   var starshipArray = [StarshipData]()
    
    enum CharacterField: Int { case name, birthyear, gender, homeworld, species, count }
    
    convenience init(character: CharacterData) {
        self.init(nibName: "CharacterDetailsTableViewController", bundle: nil)
        self.character = character
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.character?.name
        
        if self.character?.homeworldInformation == nil {
            self.fetchHomeworld {
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
        
        if self.character?.speciesInformation == nil {
            self.fetchSpecies {
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///fetchHomeworld() fetches the name of the character's homeworld
    func fetchHomeworld(completion: @escaping () -> Void) {
        guard let url = URL(string: character!.homeworld) else {
            completion()
            return
        }
        let planetTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let planetData = data {
                    let planetInfo = try JSONDecoder().decode(PlanetData.self, from: planetData)
                    print(planetInfo.name)
                    self.character!.homeworldInformation = planetInfo
                }
            } catch {
                print(error)
            }
            completion()
        }
        planetTask.resume()
        
    }
    
    func fetchSpecies(completion: @escaping () -> Void) {
        guard let url = URL(string: character!.species[0]) else {
            completion()
            return
        }
        let speciesTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let speciesData = data {
                    let speciesInfo = try JSONDecoder().decode(SpeciesData.self, from: speciesData)
                    print(speciesInfo.name)
                    self.character!.speciesInformation = speciesInfo
                }
            } catch {
                print(error)
            }
            completion()
        }
        speciesTask.resume()
        
    }
    
    // MARK: - TableView Delegate & Data Source Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharacterField.count.rawValue
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")

        let field = CharacterField(rawValue: indexPath.row) ?? .name
        switch field {
        case .name:
            cell.textLabel?.text = "Name: \(self.character?.name ?? "No Name")"

        case .birthyear:
            cell.textLabel?.text = "Birthyear: \(self.character?.birth_year ?? "Birthdate Unknown")"

        case .gender:
            cell.textLabel?.text = "Gender: \(self.character?.gender ?? "Gender Unknown")"
            
//      case .homeworld:
//          cell.textLabel?.text = "Homeworld: \(self.character?.homeworldInformation?.name ?? "Homeworld: Unknown")"
            
        case .homeworld:
            if let homeworld = self.character?.homeworldInformation?.name {
                cell.textLabel?.text = "Homeworld: \(homeworld)"
            } else {
                cell.textLabel?.text = "Homeworld: Unknown"
            }
            
        case .species:
            if let species = self.character?.speciesInformation?.name {
                cell.textLabel?.text = "Species: \(species)"
            } else {
                cell.textLabel?.text = "Species: Unknown"
            }
            
        default: break
        }

        return cell
    }
}

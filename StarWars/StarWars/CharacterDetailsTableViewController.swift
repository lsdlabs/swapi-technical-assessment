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
    var homeworld: PlanetData?
    var species: SpeciesData?
    
    
    enum CharacterField: Int { case name, birthyear, gender, homeworld, species, count }
    
    convenience init(character: CharacterData) {
        self.init(nibName: "CharacterDetailsTableViewController", bundle: nil)
        self.character = character
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.character?.name
        
        if self.character?.homeworld == nil {
            self.character?.fetchHomeworld {
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
        
        if self.character?.species == nil {
            fetchSpecies() {
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
                    //self.homeworld = planetInfo
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
            guard let url = URL(string: (character?.speciesURL[0])!) else {
                completion()
                return
            }
            let speciesTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let speciesData = data {
                        let speciesInfo = try JSONDecoder().decode(SpeciesData.self, from: speciesData)
                        print(speciesInfo.name)
                        //self.species = speciesInfo
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
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
//
//        let field = CharacterField(rawValue: indexPath.row) ?? .name
//
//        cell.textLabel?.text = self.character?.name
//        cell.textLabel?.text = self.character?.birthYear
//        cell.textLabel?.text = self.character?.gender
//
//        // Configure the cell...
//
//        return cell
//    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

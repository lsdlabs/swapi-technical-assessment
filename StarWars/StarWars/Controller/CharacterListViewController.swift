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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        // Do any additional setup after loading the view.
        DataManager.instance.fetchCharacters {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = CharacterDetailsTableViewController(character: DataManager.instance.characterArray[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

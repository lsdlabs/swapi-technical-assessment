//
//  CharacterTableViewCell.swift
//  StarWars
//
//  Created by Lauren Small on 10/28/18.
//  Copyright © 2018 Lauren Small. All rights reserved.
//

import Foundation
import UIKit

class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"
    @IBOutlet var nameLabel: UILabel!
    var character: CharacterData? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.nameLabel?.text = self.character?.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.nameLabel == nil {
            self.nameLabel = UILabel(frame: self.contentView.bounds)
            self.contentView.addSubview(self.nameLabel)
        }
        self.updateUI()
    }
}

//
//  ModuleCell.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/18/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class ModuleCell: UITableViewCell {

    @IBOutlet weak var lblPercComp: UILabel!
    @IBOutlet weak var lblModuleTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  LessonCell.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/12/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class LessonCell: UITableViewCell {
    
    @IBOutlet weak var txtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

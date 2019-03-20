//
//  LessonListCell.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/19/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class LessonListCell: UITableViewCell {

    //TODO: Some visual way to show the lesson has been already completed
    //isCompleted = false
    
    @IBOutlet weak var lblLessonTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

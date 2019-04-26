//
//  AnswerCell.swift
//  JavaTutor
//
//  Created by Logan Stahl on 3/23/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
    
    @IBOutlet weak var lblAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let coloredView = UIView()
        
        if selected {
            coloredView.backgroundColor = UIColor.init(red: 0, green: 145, blue: 0, alpha: 1)
            self.accessoryType = .checkmark
        }
        else{
            coloredView.backgroundColor = UIColor.init(red: 215, green: 245, blue: 225, alpha: 1)
            self.accessoryType = .none
        }
        self.selectedBackgroundView = coloredView
    
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

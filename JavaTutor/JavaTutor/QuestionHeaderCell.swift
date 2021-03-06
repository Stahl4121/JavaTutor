//
//  QuestionHeaderCell.swift
//  JavaTutor
//
//  Created by Logan Stahl on 4/22/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import UIKit

class QuestionHeaderCell: UITableViewCell {
    
    var btnHintAction : (() -> Void)?

    
    @IBOutlet weak var lblQuestionTitle: UILabel!
    
    @IBAction func tapHint(_ sender: UIButton) {
        if let btnAction = self.btnHintAction
        {
            btnAction()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        self.accessoryType = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

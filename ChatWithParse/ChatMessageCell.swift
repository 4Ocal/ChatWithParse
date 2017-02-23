//
//  ChatMessageCell.swift
//  ChatWithParse
//
//  Created by Calvin Chu on 2/20/17.
//  Copyright © 2017 Calvin Chu. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

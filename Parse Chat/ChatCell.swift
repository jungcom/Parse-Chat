//
//  ChatCell.swift
//  Parse Chat
//
//  Created by Anthony Lee on 10/9/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

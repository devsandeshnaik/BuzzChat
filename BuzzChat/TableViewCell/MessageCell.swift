//
//  MessageCell.swift
//  BuzzChat
//
//  Created by Sandesh on 01/03/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    static let IDENTIFIER = "customMessagCell"
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var senderEmailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageCellBaseView: UIView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.backgroundColor = .clear
        messageCellBaseView.backgroundColor = #colorLiteral(red: 0, green: 0.8271631598, blue: 0.1014914289, alpha: 0.5698173415)
        messageCellBaseView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  MessageCell.swift
//  BuzzChat
//
//  Created by Sandesh on 01/03/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {
    
    static let IDENTIFIER = "customMessagCell"
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var senderEmailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageCellBaseView: UIView!
    
    
    @IBOutlet var baseViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var baseViewLeadingConstraint: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.backgroundColor = .clear
        messageCellBaseView.layer.cornerRadius = 16
    }
    
    func loadCell(with message: Message) {
        senderEmailLabel.text = message.sender
        messageLabel.text = message.messageBody
        avatarImageView.image = UIImage(named: "avatar")
        
        //        if logged in user is sender
        if Auth.auth().currentUser?.email == message.sender {
            baseViewLeadingConstraint.isActive = false
            messageCellBaseView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            senderEmailLabel.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        } else{
            baseViewLeadingConstraint.isActive = true
            messageCellBaseView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            senderEmailLabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

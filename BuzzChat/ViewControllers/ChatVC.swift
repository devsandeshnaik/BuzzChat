//
//  ChatVC.swift
//  BuzzChat
//
//  Created by Sandesh on 26/02/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController {
    
    
    private var chatMessages = [Message]()
    
    private var gesture: UITapGestureRecognizer!
    
    @IBOutlet weak var chatsTableView               : UITableView!
    @IBOutlet weak var messageTextField             : UITextField!
    @IBOutlet weak var textFieldBottonConstraint    : NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut(_:)))
        
        chatsTableView.dataSource = self
        chatsTableView.delegate = self
        chatsTableView.rowHeight = UITableView.automaticDimension
        chatsTableView.separatorStyle = .none
        chatsTableView.tableFooterView = UIView()
        chatsTableView.backgroundColor = .clear
        
        chatsTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: MessageCell.IDENTIFIER)
        
        messageTextField.delegate = self
        
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        chatsTableView.addGestureRecognizer(tapgesture)
        
        retriveMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange), name: UIResponder.keyboardWillHideNotification,object: nil)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardFrameWillChange(_ notification: Notification) {
        if let keybardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            UIView.animate(withDuration: 0.3) {
                self.textFieldBottonConstraint.constant = keybardFrame.height - self.view.safeAreaInsets.bottom
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func logOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sender.isEnabled = false
        
//        Creating database for messages
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextField.text
        ]
        
        messageDB.childByAutoId().setValue(messageDictionary) { (error, reference) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Message saved succesfully")
                self.messageTextField.isEnabled = true
                sender.isEnabled = true
                self.messageTextField.text = ""
            }
        }
    }
    
    private func retriveMessages() {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { snapShot in
            guard let snapShotValue = snapShot.value as? [String: String] else  {
                print("Unknown snapshot value")
                return
            }
            
            let text = snapShotValue["MessageBody"]!
            let sender = snapShotValue["Sender"]!
            
            let message = Message(sender: sender, messageBody: text)
            self.chatMessages.append(message)
            self.chatsTableView.reloadData()
        }
    }
}


extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let messageCell = tableView.dequeueReusableCell(withIdentifier: MessageCell.IDENTIFIER) as? MessageCell {
            messageCell.loadCell(with: chatMessages[indexPath.row])
            return messageCell
            
        }
        return UITableViewCell()
    }
    
    
}


extension ChatVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ChatVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.textFieldBottonConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}



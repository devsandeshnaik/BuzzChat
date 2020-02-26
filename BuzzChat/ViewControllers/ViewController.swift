//
//  ViewController.swift
//  BuzzChat
//
//  Created by Sandesh on 24/02/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

enum UserAction {
    case Login
    case Register
}


class ViewController: UIViewController {
    
    private var selectedAction: UserAction!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func registerUser(_ sender: UIButton) {
        selectedAction = .Register
        performSegue(withIdentifier: "loginRegister", sender: self)
    }

    
    @IBAction func loginUser(_ sender: UIButton) {
        selectedAction = .Login
        performSegue(withIdentifier: "loginRegister", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LoginAndRegistrationVC {
            destination.actionSelectedByUser = selectedAction
        }
    }
}


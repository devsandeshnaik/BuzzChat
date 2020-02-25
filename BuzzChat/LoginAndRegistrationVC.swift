//
//  LoginAndRegistrationVC.swift
//  BuzzChat
//
//  Created by Sandesh on 25/02/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class LoginAndRegistrationVC: UIViewController {
    
    
    var actionSelectedByUser: UserAction?
    
    @IBOutlet weak var headerLabel          : UILabel!
    @IBOutlet weak var emailTextField       : UITextField!
    @IBOutlet weak var passwordTextField    : UITextField!
    @IBOutlet weak var loginRegisterButton  : UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard  actionSelectedByUser != nil  else { fatalError("LoginAndRegistrationVC: Developer forgot to set actionSelectedByUser") }
        
        if actionSelectedByUser! == .Register {
            headerLabel.text = "Register"
            loginRegisterButton.setTitle("Register", for: .normal)
        } else {
            headerLabel.text = "Login"
            loginRegisterButton.setTitle("Login", for: .normal)
        }
    }
    
    
    private func registerUser() {
        
    }
    
    private func loginUser() {
        
    }
    
    @IBAction func loginOrRegisterUser() {
        if actionSelectedByUser! == .Register { registerUser() } else { loginUser() }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

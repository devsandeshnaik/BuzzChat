//
//  LoginAndRegistrationVC.swift
//  BuzzChat
//
//  Created by Sandesh on 25/02/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit
import Firebase
import Progress
	
class LoginAndRegistrationVC: UIViewController {
    
    
    var actionSelectedByUser: UserAction?
    
    @IBOutlet weak var headerLabel          : UILabel!
    @IBOutlet weak var emailTextField       : UITextField!
    @IBOutlet weak var passwordTextField    : UITextField!
    @IBOutlet weak var loginRegisterButton  : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
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
        
        //        Firebase authentication
        Prog.start(in: self.view, .activityIndicator)
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error != nil { print(error!.localizedDescription )} else {
                print("Registration Sucessful")
                Prog.end(in: self.view)
                self.performSegue(withIdentifier: "startChatting", sender: self)
            }
        }
        
    }
    
    private func loginUser() {
        Prog.start(in: self.view, .activityIndicator)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error != nil { print(error!.localizedDescription )} else {
                print("Login Sucessful")
                Prog.end(in: self.view)
                self.performSegue(withIdentifier: "startChatting", sender: self)
            }
        }
    }
    
    @IBAction func loginOrRegisterUser() {
        if actionSelectedByUser! == .Register { registerUser() } else { loginUser() }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

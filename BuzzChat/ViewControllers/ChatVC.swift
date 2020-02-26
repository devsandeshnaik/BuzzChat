//
//  ChatVC.swift
//  BuzzChat
//
//  Created by Sandesh on 26/02/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

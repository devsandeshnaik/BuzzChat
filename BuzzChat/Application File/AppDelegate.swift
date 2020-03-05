//
//  AppDelegate.swift
//  BuzzChat
//
//  Created by Sandesh on 24/02/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit
import Firebase
 
@UIApplicationMain
@available(iOS 13,*)
class AppDelegate: UIResponder, UIApplicationDelegate {

    #warning("Add progress indicator")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }



}


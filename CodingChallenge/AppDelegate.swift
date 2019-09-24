//
//  AppDelegate.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setCoodinator()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Log.setLastVisitDate()
    }

    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        setCoodinator()
        return true
    }
    
    private func setCoodinator() {
        if let initialViewController = window?.rootViewController as? MainNavigationController {
            coordinator = Coordinator(mainViewController: initialViewController)
        }
    }
}


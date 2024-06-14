//
//  SystemBoots.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

class SystemBoots {
    
    // MARK: - Singleton
    static let instance = SystemBoots()
    
    // MARK: - Variables
    weak var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    // MARK: - Actions
    func changeRoot(window: inout UIWindow?, rootController: UIViewController) {
        // Setup app's window
        guard window == nil else {
            window?.rootViewController = UINavigationController(rootViewController: rootController)
            window?.makeKeyAndVisible()
            return
        }
        window = UIWindow(frame: ScreenUtils.screenBounds)
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: rootController)
        window?.makeKeyAndVisible()
    }
}

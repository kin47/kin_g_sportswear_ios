//
//  SharedData.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

// MARK: - General information
class SharedData {

    // Access token for requesting APIs
    class var accessToken: String? {
        get {
            return (UserDefaults.standard.value(forKey: "ApiAccessToken") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "ApiAccessToken")
        }
    }
    
    // APNS token is saved in app
    class var deviceToken: String? {
        get {
            return (UserDefaults.standard.value(forKey: "NotificationToken") as? String)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "NotificationToken")
        }
    }
}

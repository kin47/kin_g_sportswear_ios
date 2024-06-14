//
//  NotificationPermission.swift
//  KinGSportswear
//
//  Created by vinhdd on 2/19/19.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationPermission {
    
    // MARK: - Static variables
    static func getAuthorizationStatus(completion: @escaping ((_ status: UNAuthorizationStatus) -> Void)) {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { settings in
            completion(settings.authorizationStatus)
        })
    }
}

//
//  NotificationService.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyJSON

class NotificationService: NSObject {
    
    // MARK: - Singleton
    static var instance = NotificationService()
    
    // MARK: - Variables
    // Check if user has registered for remote notifications or not
    var didRegisterRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    // Cache push notification data to show (when app is killed or not being opened)
    var launchRemoteData: [AnyHashable : Any]?
    
    // MARK: - Register push notification
    func registerPushNotification(application: UIApplication = UIApplication.shared, completion: ((Bool) -> Void)? = nil) {
        let authOptions: UNAuthorizationOptions = [.badge, .alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions,
                                                                completionHandler: { granted, error in
                                                                    DispatchQueue.main.async {
                                                                        if error == nil && granted {
                                                                            application.registerForRemoteNotifications()
                                                                            completion?(true)
                                                                        } else {
                                                                            completion?(false)
                                                                        }
                                                                    }
                                                                })
        UNUserNotificationCenter.current().delegate = self
    }
    
    // MARK: - Supporting methods
    func getPendingLocalNotificationsCount(completion: @escaping ((_ count: Int) -> Void)) {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            completion(requests.count)
        })
    }
}

// MARK: - Handle device token
extension NotificationService {
    func parseDeviceToken(data: Data) {
        let deviceToken = data.reduce("", {$0 + String(format: "%02X", $1)})
        SharedData.deviceToken = deviceToken
        sendDeviceTokenToServer(deviceToken: deviceToken)
    }
    
    func sendDeviceTokenToServer(deviceToken: String, completion: (() -> Void)? = nil) {
        print("▶︎ [Push Notification] - Device Token: \(deviceToken)")
        // TODO: - Send device token to server
    }
}

// MARK: - Handle push notification & local notification data
extension NotificationService {
    // MARK: - Receive data from remote & local notifications
    func received(notification userInfo: [AnyHashable: Any], application: UIApplication, isRemoteNoti: Bool) {
        // Write your code
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Check if this is a local notification or remote notification
        var isRemoteNoti = false
        if let trigger = response.notification.request.trigger, trigger.isKind(of: UNPushNotificationTrigger.self) {
            // User did tap at remote notification
            isRemoteNoti = true
        }
        received(notification: response.notification.request.content.userInfo, application: UIApplication.shared, isRemoteNoti: isRemoteNoti)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let jsonData = JSON(notification.request.content.userInfo)
        print("▶︎ [User Notification Center] - Received message:\n\(jsonData)\n")
        // TODO: Check if you need to show notification alert or not by calling completionHandler
        completionHandler([.alert, .badge, .sound])
    }
}

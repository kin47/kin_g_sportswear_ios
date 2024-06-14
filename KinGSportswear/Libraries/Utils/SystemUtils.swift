//
//  SystemInfo.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 10/29/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

// MARK: - App general information
class SystemUtils {
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let schemeName = ProcessInfo.processInfo.environment["targetName"] ?? ""
    static let osName = UIDevice.current.systemName
    static let osVersion = UIDevice.current.systemVersion
    static let uuid = UUID().uuidString
    static var bundleId: String? {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }
    static let appIdOnAppStore: String = "" // Replace with app id on AppstoreConnect
    static var appUrlOnAppStore: URL? {
        let urlStr = String(format: "itms-apps://itunes.apple.com/app/bars/id%@", appIdOnAppStore)
        return URL(string: urlStr)
    }
}

// MARK: - Encoding
extension SystemUtils {
    static let shiftJISEncoding = String.Encoding.shiftJIS
    static let utf8Encoding = String.Encoding.utf8
}

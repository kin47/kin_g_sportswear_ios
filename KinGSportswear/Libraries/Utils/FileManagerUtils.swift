//
//  FileManagerUtils.swift
//  KinGSportswear
//
//  Created by vinhdd on 2/19/19.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

class FileManagerUtils {
    
    // MARK: - Static variables
    static let fileManager: FileManager  = FileManager.default
    static var documentDirectoryUrl: URL {
        return FileManagerUtils.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // MARK: - Static functions
    @discardableResult
    static func saveFileWith(data: Data, name: String, atUrl url: URL = FileManagerUtils.documentDirectoryUrl) -> URL? {
        let filePath = url.appendingPathComponent("\(name)")
        do {
            try data.write(to: filePath, options: .atomic)
            return filePath
        } catch { }
        return nil
    }
    
    @discardableResult
    static func removeFileAt(url: URL) -> Bool {
        do {
            try FileManagerUtils.fileManager.removeItem(at: url)
            return true
        } catch { }
        return false
    }
}

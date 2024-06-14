//
//  UIFont+Extension.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

extension UIFont {
    // Name of font will be defined according to project
    static func normal(size: CGFloat) -> UIFont {
        return UIFont(name: "YuGothic-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Name of font will be defined according to project
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "YuGothic-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}

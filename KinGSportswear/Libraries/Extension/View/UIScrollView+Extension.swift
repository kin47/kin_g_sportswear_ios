//
//  UIScrollView+Extension.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToVeryBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.height + contentInset.bottom)
        if bottomOffset.y > contentOffset.y {
            setContentOffset(bottomOffset, animated: animated)
        }
    }
}

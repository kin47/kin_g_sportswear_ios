//
//  IndicatorViewer.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import SVProgressHUD

class IndicatorViewer {
    static func show() {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundLayerColor(UIColor.black.alpha(0.2))
        SVProgressHUD.show()
    }

    static func hide() {
        SVProgressHUD.dismiss()
    }
}

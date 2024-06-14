//
//  ColorImageView.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

@IBDesignable class ColorImageView: UIImageView {

    // MARK: - Inspectable
    @IBInspectable var color: UIColor = .white
    
    // MARK: - UI
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        image = image?.template
        tintColor = color
    }
}

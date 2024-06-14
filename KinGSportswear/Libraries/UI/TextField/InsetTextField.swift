//
//  InsetTextField.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//
import UIKit

class InsetTextField: UITextField {

    // MARK: - Inspectable
    @IBInspectable var insetTop: CGFloat = 0
    @IBInspectable var insetLeft: CGFloat = 10
    @IBInspectable var insetBottom: CGFloat = 0
    @IBInspectable var insetRight: CGFloat = 10
    
    private var insets: UIEdgeInsets {
        return UIEdgeInsets(top: insetTop, left: insetLeft, bottom: insetBottom, right: insetRight)
    }
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}

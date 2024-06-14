//
//  TapActionView.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

class TapActionView: UIView {

    // MARK: - Closures
    var didTap: (() -> Void)?
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(sender:)))
        addGestureRecognizer(tapGesture)
    }
    // MARK: - Action
    @objc private func tapGestureAction(sender: UITapGestureRecognizer) {
        didTap?()
    }

}

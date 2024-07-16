//
//  ImageContentVC.swift
//  KinGSportswear
//
//  Created by Minh Tran on 7/11/24.
//  Copyright © 2024 vinhdd. All rights reserved.
//

import UIKit

class ImageContentVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = imageUrl {
            imageView.loadImage(url: URL(string: imageUrl))
        }
    }
}

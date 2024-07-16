//
//  LoadingVC.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit

class LoadingVC: BaseVC {

    // MARK: - Outlets
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var window: UIWindow?
    var firebaseAuth: FirebaseAuthenticationProtocol = FirebaseAuthenticationImpl()
    
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        requestApi()
    }

    // MARK: - Setup
    private func setupView() {
        // Do nothing
    }
    
    // MARK: - Data management
    
    // MARK: - Action
    private func requestApi() {
        let result = firebaseAuth.getUserInfo()
        switch result {
        case .success(let user):
            let coreVC = CoreVC.create()
            SystemBoots.instance.changeRoot(window: &window, rootController: coreVC)
        case .failure(_):
            LoginVC.push()
        }
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods

}

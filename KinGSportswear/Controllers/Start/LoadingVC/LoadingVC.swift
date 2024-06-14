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
        AnswerListAPI(order: "desc",
                      sort: "activity",
                      site: "stackoverflow").execute(target: self, success: { response in
            print("Got list: \(response.answerList.count) elements")
            LoginVC.push()
        }, failure: { error in
            // Do nothing
        })
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods

}

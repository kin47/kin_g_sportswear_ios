//
//  Sample.swift
//  KinGSportswear
//
//  Created by Thành on 21/11/2023.
//  Copyright © 2023 vinhdd. All rights reserved.
//

import Foundation
class SampleIAP {
    func somethings() {
        if IAPManager.shared.canMakePayments() {
            IAPManager.shared.buy(itemId: "item_id", completion: { buyStage,verifySuccess,itemId in
                
            })
        }
        IAPManager.shared.checkPendingTransaction(completion: { buyStage,verifySuccess,itemId in
            
        })
    }
}

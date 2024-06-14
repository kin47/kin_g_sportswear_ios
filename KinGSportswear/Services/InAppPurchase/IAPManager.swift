//
//  IAPManager.swift
//  KinGSportswear
//
//  Created by thanhnt3 on 21/11/23.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import StoreKit
public enum PurcharseBuyStage {
    case success
    case failed
    case pending
}
public typealias InAppPurcharseCompletion = (_ buyStage: PurcharseBuyStage,_ verifySuccess: Bool,_ itemId: String?) -> ()

class IAPManager: NSObject {
    private var iapCompletion: InAppPurcharseCompletion?
    private var iapExecuter: IAPExecutor?
    private var isBuying: Bool = false
    static let shared: IAPManager = IAPManager()
    
    private override init() {
        super.init()
        iapExecuter = IAPExecutor()
        iapExecuter!.delegate = self
    }
    
    /* Start buy a item */
    func buy(itemId: String, completion: @escaping InAppPurcharseCompletion) {
        self.iapCompletion = completion
        IndicatorViewer.show()
        isBuying = true
        iapExecuter?.buy(itemId: itemId)
    }
    
    /* Call this func after logged in to check has purcharsed transaction but verify not yet */
    func checkPendingTransaction(completion: @escaping InAppPurcharseCompletion) {
        self.iapCompletion = completion
        handlePendingTransaction()
    }
    
    /* Check all in transaction queue
     - Does not support verify multiple transactions at the same time
     - Need wait some seconds for clear transaction before execute next verify
    */
    private func handlePendingTransaction() {
        if SKPaymentQueue.default().transactions.count > 0 {
            for transaction in SKPaymentQueue.default().transactions {
                if transaction.transactionState ==  .purchased {
                    verifyPurchase(transaction: transaction, completion: {[weak self] status in
                        if status {
                            self?.handleBuySucceed(transaction: transaction)
                        } else {
                            self?.handleBuyCannotComplete(transaction: transaction)
                        }
                        //Execute next verify
                        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: {
                            self?.handlePendingTransaction()
                        })
                    })
                    break
                }
            }
        }
    }

    private func verifyPurchase(transaction: SKPaymentTransaction, completion:  @escaping (_ status: Bool) -> ()) {
        guard let _ = transaction.transactionIdentifier, let _ = getPaymentReceipt() else {
            handleBuyFailed()
            return
        }
        // Call api to verify purchase, then call completion
    }
}

// MARK: - In-App Purchase supporting functions
extension IAPManager {
    func canMakePayments() -> Bool {
        return !isBuying && iapExecuter?.canMakePayment() ?? false
    }
    
    private func getPaymentReceipt() -> String? {
        if let url = Bundle.main.appStoreReceiptURL, let data = try? Data(contentsOf: url) {
            return data.base64EncodedString()
        }
        return nil
    }
}

// Show alerts
extension IAPManager {
    private func handleBuySucceed(transaction: SKPaymentTransaction) {
        DispatchQueue.main.async {
            IndicatorViewer.hide()
            // Write code to show your own alert
            self.isBuying = false
            self.iapExecuter?.clear(transaction: transaction)
            self.iapCompletion?(.success, true, transaction.payment.productIdentifier)
        }
    }
    
    private func handleBuyCannotComplete(transaction: SKPaymentTransaction) {
        DispatchQueue.main.async {
            IndicatorViewer.hide()
            // Write code to show your own alert
            self.isBuying = false
            self.iapExecuter?.clear(transaction: transaction)
            self.iapCompletion?(.success, false, transaction.payment.productIdentifier)
        }
    }
    
    private func handleBuyFailed() {
        DispatchQueue.main.async {
            IndicatorViewer.hide()
            // Write code to show your own alert
            self.isBuying = false
            self.iapCompletion?(.failed, false, nil)
        }
    }
    
    private func handleBuyPending(transaction: SKPaymentTransaction?) {
        DispatchQueue.main.async {
            IndicatorViewer.hide()
            // Write code to show your own alert
            self.isBuying = false
            self.iapCompletion?(.pending, false, transaction?.payment.productIdentifier)
        }
    }
}
extension IAPManager: IAPExecutorDelegate {
    func didUpdateIAPSessionState(_ success: Bool?,_ transaction: SKPaymentTransaction?) {
        if let _success = success, let transaction = transaction {
            if _success {
                self.verifyPurchase(transaction: transaction, completion:  {[weak self] status in
                    if status {
                        self?.handleBuySucceed(transaction: transaction)
                    } else {
                        self?.handleBuyCannotComplete(transaction: transaction)
                    }
                })
            } else {
                self.handleBuyFailed()
            }
        } else {
            self.handleBuyPending(transaction: transaction)
        }
    }
}

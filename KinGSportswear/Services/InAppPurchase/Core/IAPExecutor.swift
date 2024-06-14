//
//  InAppPurchaseService.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 10/27/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import StoreKit

protocol IAPExecutorDelegate: AnyObject {
    func didUpdateIAPSessionState(_ success: Bool?,_ transaction: SKPaymentTransaction?)
}
class IAPExecutor: NSObject {
    // Variables
    fileprivate var productRequest: SKProductsRequest?
    var itemId: String!
    weak var delegate: IAPExecutorDelegate?
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
}

// MARK: - Handle StoreKit functions
extension IAPExecutor {
    private func requestProducts() {
        // Cancel current request
        productRequest?.cancel()
        productRequest = nil
        
        // Create new request
        productRequest = SKProductsRequest(productIdentifiers: Set([itemId]))
        productRequest?.delegate = self
        productRequest?.start()
    }
    
    func buy(itemId: String) {
        self.itemId = itemId
        requestProducts()
    }
    
    func canMakePayment() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
}

extension IAPExecutor: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let list = response.products
        if let product = list.filter({ $0.productIdentifier == self.itemId }).first {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            delegate?.didUpdateIAPSessionState(false, nil)
        }
        clearProductRequest()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        delegate?.didUpdateIAPSessionState(false, nil)
        clearProductRequest()
    }
    
    private func clearProductRequest() {
        productRequest = nil
    }
}

extension IAPExecutor: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchased, .restored:
                purchased(transaction: $0)
            case .failed:
                failed(transaction: $0)
            case .deferred:
                pending(transaction: $0)
            case .purchasing: break
            }
        }
    }
    
    private func purchased(transaction: SKPaymentTransaction) {
        delegate?.didUpdateIAPSessionState(true, transaction)
    }
    
    private func failed(transaction: SKPaymentTransaction) {
        delegate?.didUpdateIAPSessionState(false, transaction)
        clear(transaction: transaction)
    }
    
    private func pending(transaction: SKPaymentTransaction) {
        delegate?.didUpdateIAPSessionState(nil, transaction)
    }
    
    func clear(transaction: SKPaymentTransaction) {
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

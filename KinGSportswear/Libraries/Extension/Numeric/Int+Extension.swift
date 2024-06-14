//
//  Int+Extension.swift
//  KinGSportswear
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//
import Foundation

extension Int {
    func string() -> String {
        return "\(self)"
    }
    
    func addCommaWith(separator: String = ",") -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = separator
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self))
    }
}

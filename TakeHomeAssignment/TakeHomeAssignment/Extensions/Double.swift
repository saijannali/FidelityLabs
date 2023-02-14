//
//  Extensions.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/12/23.
//

import Foundation
import SwiftUI

extension Double {
    
    /// Converts a Double into a Currency as a String with 2 deciamls places
    /// ```
    ///   Converts 1234.56 to "$1234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    private var currencyFormatter2: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}



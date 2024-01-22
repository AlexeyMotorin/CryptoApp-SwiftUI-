//
//  Double+extension.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import Foundation

extension Double {

    /// Convert a Double into a Currency with 2 decimal  places
    /// ```
    /// Convert 1234.56 to $1.1234,56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // <- default value
        formatter.currencyCode = "usd" // <- change currency
        formatter.currencySymbol = "$" // <- change symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    /// Convert a Double into a Currency as a String with 2 decimal  places
    /// ```
    /// Convert 1234.56 to" $1.1234,56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "0.00"
    }

    /// Convert a Double into a Currency with 2-6 decimal  places
    /// ```
    /// Convert 1234.56 to $1.1234,56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // <- default value
        formatter.currencyCode = "usd" // <- change currency
        formatter.currencySymbol = "$" // <- change symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }

    /// Convert a Double into a Currency as a String with 2-6 decimal  places
    /// ```
    /// Convert 1234.56 to" $1.1234,56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0.00"
    }

    /// Convert a Double into string representation
    /// ```
    /// Convert 1.23456 to "1.12"

    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }

    /// Convert a Double into string representation with percent symbol
    /// ```
    /// Convert 1.23456 to "1.12%"

    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}

//
//  StringConstants.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import Foundation

struct L10 {
    // image system icon
    static let info = "info"
    static let plus = "plus"
    static let chevronRight = "chevron.right"
    static let questionmark = "questionmark"
    static let magnifyingglass = "magnifyingglass"
    static let xmarkCircleFill = "xmark.circle.fill"
    static let xmark = "xmark"
    static let checkMark = "checkmark"
    static let triangleFill = "triangle.fill"
    static let refreshImage = "goforward"
    static let chevronDown = "chevron.down"

    static let homeHeaderTextPrice = String(localized: "homeHeaderTextPrice")
    static let homeHeaderTextPortfolio = String(localized: "homeHeaderTextPortfolio")
    static let coinTitle = String(localized: "coin")
    static let holdingTitle = String(localized: "holding")
    static let priceTitle = String(localized: "price")
    static let searchBarPlaceholder = String(localized: "searchBarPlaceholder")
    static let marketCap = String(localized: "marketCap")
    static let totalVolume = String(localized: "totalVolume")
    static let btcDominance = String(localized: "btcDominance")
    static let portfolio = String(localized: "portfolio")

    // PortfolioView
    static let portfolioViewTitle = String(localized: "EditPortfolio")
    static let saveButtonTitle = String(localized: "save")
    static let amountHolding = String(localized: "amountHolding")
    static let currentValue = String(localized: "currentValue")
    static let placeholderAmountHolding = String(localized: "placeholderAmountHolding")
    static func currentPriceOf(_ value: String?) -> String {
        let localizedString = NSLocalizedString("currentPriceOf", comment: "")
        return String(format: localizedString, value ?? "")
    }
}

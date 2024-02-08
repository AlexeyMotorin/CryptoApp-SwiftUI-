//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 07.02.2024.
//

import Foundation

// JSON data
/*
 URL "https://api.coingecko.com/api/v3/global"
 
 JSON Response
 {
 "data":{
    "active_cryptocurrencies":12628,
    "upcoming_icos":0,
    "ongoing_icos":49,
    "ended_icos":3376,
    "markets":931,
    "total_market_cap":{
        "btc":40340940.23461699,
        "eth":734171774.4311134,
        "ltc":25517540076.18398,
    },
    "total_volume": {
         "btc": 1187089.4360210386,
         "eth": 21606977.94649065,
         "ltc": 751045607.359486,
    }
    "market_cap_percentage":{
        "btc":48.637748366516945,
        "eth":16.369639789489273
    },
    "market_cap_change_percentage_24h_usd":0.8694387591608738,
    "updated_at":1707304763
    }
 }

 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }

    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == usd }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }

    var volume: String {
        if let item = totalVolume.first(where: { $0.key == usd }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }

    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == btc }) {
            return item.value.asPercentString()
        }
        return ""
    }
}

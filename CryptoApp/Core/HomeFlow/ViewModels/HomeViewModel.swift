//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 24.01.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    init() {}
}

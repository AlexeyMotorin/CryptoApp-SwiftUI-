//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 25.01.2024.
//

import Foundation
import Combine

final class CoinDataService {
    @Published var allCoins: [CoinModel] = []

    private var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

    func getCoins() {
        guard let url = URL(string: coingeckoUrlString) else { return }

        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}

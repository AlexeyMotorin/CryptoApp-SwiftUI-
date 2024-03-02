//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 02.03.2024.
//

import Foundation

import Foundation
import Combine

final class CoinDetailDataService {
    @Published var detailData: CoinDetailModel?

    private var coinDetailSubscription: AnyCancellable?

    init(coinId: String) {
        getCoinDetail(coinId: coinId)
    }

    func getCoinDetail(coinId: String) {
        let stringURL =  "https://api.coingecko.com/api/v3/coins/\(coinId)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        guard let url = URL(string: stringURL) else { return }

        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoin in
                self?.detailData = returnedCoin
                self?.coinDetailSubscription?.cancel()
            })
    }
}

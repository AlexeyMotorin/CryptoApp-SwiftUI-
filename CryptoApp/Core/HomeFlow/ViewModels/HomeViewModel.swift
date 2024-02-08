//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 24.01.2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentageChange: -7)
    ]

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    @Published var searchText = ""

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancelable = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }
}

private extension HomeViewModel {
    func addSubscribers() {
        // update addCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelable)

        // updates marketData
        marketDataService.$marketData
            .map(mapMarketGlobalData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancelable)
    }

    func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()

        return coins.filter { (coin) -> Bool  in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }

    func mapMarketGlobalData(data: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = data else { return stats }

        let marketCup = StatisticModel(title: L10.marketCap, value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: L10.totalVolume, value: data.volume)
        let btcDominance = StatisticModel(title: L10.btcDominance, value: data.btcDominance)
        let portfolio = StatisticModel(title: L10.portfolio, value: "$0.00", percentageChange: 0)

        stats.append(contentsOf: [
            marketCup,
            volume,
            btcDominance,
            portfolio
        ])

        return stats
    }
}

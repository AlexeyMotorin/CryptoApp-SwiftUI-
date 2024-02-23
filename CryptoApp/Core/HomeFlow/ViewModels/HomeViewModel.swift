//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 24.01.2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var statistics: [StatisticModel] = []

    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    @Published var searchText = ""

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancelable = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    func updatesPortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
}

// MARK: Private methods
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

        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancelable)

        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
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

    func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioCoins: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioCoins.first(where: { $0.coinId == coin.id }) else { return nil }
                return coin.updateHoldings(amount: entity.amount)
            }
    }

    func mapMarketGlobalData(data: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = data else { return stats }

        let marketCup = StatisticModel(title: L10.marketCap, value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: L10.totalVolume, value: data.volume)
        let btcDominance = StatisticModel(title: L10.btcDominance, value: data.btcDominance)

        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)

        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                return currentValue / (1 + percentChange)
            }
            .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

        let portfolio = StatisticModel(
            title: L10.portfolio,
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)

        stats.append(contentsOf: [
            marketCup,
            volume,
            btcDominance,
            portfolio
        ])

        return stats
    }
}

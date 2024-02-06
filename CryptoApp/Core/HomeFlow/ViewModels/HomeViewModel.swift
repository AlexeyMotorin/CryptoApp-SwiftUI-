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

    private let dataService = CoinDataService()
    private var cancelable = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }
}

private extension HomeViewModel {
    func addSubscribers() {
        // update addCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
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
}

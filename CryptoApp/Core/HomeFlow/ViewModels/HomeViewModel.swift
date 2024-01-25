//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 24.01.2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    private let dataService = CoinDataService()
    private var cancelable = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }
}


private extension HomeViewModel {
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelable)
    }
}

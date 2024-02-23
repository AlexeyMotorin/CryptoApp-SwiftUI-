//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 07.02.2024.
//

import Foundation
import Combine

final class MarketDataService {
    @Published var marketData: MarketDataModel? = nil

    private var marketDataSubscription: AnyCancellable?

    init() {
        getData()
    }

    func getData() {
        guard let url = URL(string: marketDataURLString) else { return }

        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}

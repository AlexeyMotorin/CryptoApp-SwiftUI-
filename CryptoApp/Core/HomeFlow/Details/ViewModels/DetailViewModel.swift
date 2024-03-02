//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 02.03.2024.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published var coinDetail: CoinDetailModel? = nil
    private let coinDetailDataService: CoinDetailDataService
    private var cancellable: AnyCancellable?

    init(coinId: String) {
        self.coinDetailDataService = CoinDetailDataService(coinId: coinId)
        addSubscribers()
    }
    deinit {
        cancellable?.cancel()
    }
}

private extension DetailViewModel {
    func addSubscribers() {
        cancellable = coinDetailDataService.$detailData
            .sink { [weak self] coinDetail in
                self?.coinDetail = coinDetail
            }
    }
}

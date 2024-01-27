//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 27.01.2024.
//

import SwiftUI
import Combine

final class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = false

    private var cancelable = Set<AnyCancellable>()

    private let coinModel: CoinModel
    private let dataService: CoinImageService

    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        self.dataService = CoinImageService(coinModel: coinModel)
        self.isLoading = true
        addSubscribers()
    }
}

private extension CoinImageViewModel {
    func addSubscribers() {
        dataService.$uiImage
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self] uiImage in
                self?.image = uiImage
            })
            .store(in: &cancelable)
    }
}

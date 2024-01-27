//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 27.01.2024.
//

import SwiftUI
import Combine

final class CoinImageService {

    @Published var uiImage: UIImage? = nil

    private var imageSubscription: AnyCancellable?
    private let coinModel: CoinModel

    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        getCoinImage()
    }
}

extension CoinImageService {
    private func getCoinImage() {
        guard let url = URL(string: coinModel.image) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                self?.uiImage = image
                self?.imageSubscription?.cancel()
            })
    }
}

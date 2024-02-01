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
    private let fileManger = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String

    init(coinModel: CoinModel) {
        self.coinModel = coinModel
        self.imageName = coinModel.id
        getCoinImage()
    }
}

extension CoinImageService {
    func getCoinImage() {
        if let savedImage = fileManger.getImage(imageName: imageName, folderName: folderName) {
            uiImage = savedImage
        } else {
            downloadCoinImage()
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coinModel.image) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                guard let self, let image = image else { return }
                self.uiImage = image
                self.imageSubscription?.cancel()
                self.fileManger.saveImage(uiImage: image, imageName: imageName, folderName: folderName)
            })
    }
}

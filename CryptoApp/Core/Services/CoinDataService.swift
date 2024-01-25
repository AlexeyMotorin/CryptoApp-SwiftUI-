//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 25.01.2024.
//

import Foundation
import Combine

final class CoinDataService {
    @Published var allCoins: [CoinModel] = []

    var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

}

private extension CoinDataService {
    func getCoins() {
        guard let url = URL(string: coingeckoUrlString) else { return }

        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200,
                      response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}

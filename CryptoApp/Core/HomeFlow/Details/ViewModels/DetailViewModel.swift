//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 02.03.2024.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {

    @Published var overviewStatistics : [StatisticModel] = []
    @Published var additionalStatistics : [StatisticModel] = []

    @Published var coin: CoinModel
    private let coinDetailDataService: CoinDetailDataService
    private var cancellable: AnyCancellable?

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coinId: coin.id)
        addSubscribers()
    }
    
    deinit {
        cancellable?.cancel()
    }
}
 
private extension DetailViewModel {
    func addSubscribers() {
        cancellable = coinDetailDataService.$detailData
            .combineLatest($coin)
            .map(mapToStatistics)
            .sink { [weak self] returnedArray in
                self?.overviewStatistics = returnedArray.overview
                self?.additionalStatistics = returnedArray.additional
            }
    }

    private func mapToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overviewArray = mapToOverviewStatistics(coinModel: coinModel)
        let additionalArray = mapToAdditionalStatistics(coinDetailModel: coinDetailModel, coinModel: coinModel)

        return (overviewArray, additionalArray)
    }

    private func mapToOverviewStatistics(coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let priceChanges = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: L10.currentPrice, value: price, percentageChange: priceChanges)

        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: L10.marketCapitalization, value: marketCap, percentageChange: marketCapPercentChange)

        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: L10.rank, value: rank)

        let volume =  "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: L10.volume, value: volume)

        return [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
    }

    private func mapToAdditionalStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: L10.high24, value: high)

        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: L10.low24, value: low)

        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: L10.priceChange24, value: priceChange, percentageChange: pricePercentChange2)

        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: L10.marketCapChange24, value: marketCapChange, percentageChange:
        marketCapPercentChange2)

        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: L10.blockTime, value: blockTimeString)

        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: L10.hashingAlgorithm, value: hashing)

        return  [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
    }
}

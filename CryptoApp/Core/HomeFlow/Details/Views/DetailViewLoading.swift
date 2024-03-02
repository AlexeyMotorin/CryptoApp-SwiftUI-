//
//  DetailViewLoading.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 25.02.2024.
//

import SwiftUI


struct DetailViewLoading: View {

    @Binding var coin: CoinModel?

    init(coin: Binding<CoinModel?>) {
        self._coin = coin
    }

    var body: some View {
        if let coin {
            DetailView(coinId: coin.id)
        }
    }
}

// MARK: Preview
struct DetailViewLoading_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewLoading(coin: .constant(dev.coin))
    }
}

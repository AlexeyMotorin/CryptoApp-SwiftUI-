//
//  DetailView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 25.02.2024.
//

import SwiftUI

struct DetailView: View {

    let coin: CoinModel

    init(coin: CoinModel) {
        self.coin = coin
    }

    var body: some View {
        Text(coin.name)
    }
}

// MARK: Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}

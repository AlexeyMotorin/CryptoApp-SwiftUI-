//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 13.02.2024.
//

import SwiftUI

struct CoinLogoView: View {

    let coin: CoinModel

    var body: some View {
        VStack {
            CoinImageView(coinModel: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}


// MARK: Preview
struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
    }
}

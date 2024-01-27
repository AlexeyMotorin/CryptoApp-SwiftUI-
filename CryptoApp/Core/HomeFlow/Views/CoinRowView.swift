//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool

    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn { centerColumn }
            rightColumn
        }
        .font(.subheadline)
    }
}

// MARK: Components
private extension CoinRowView {

    var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
           CoinImageView(coinModel: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }

    var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }

    var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

// MARK: CANVAS
struct CoinHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                CoinRowView(coin: dev.coin, showHoldingsColumn: false)
            }
            .preferredColorScheme(.light)

            VStack {
                CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                CoinRowView(coin: dev.coin, showHoldingsColumn: false)
            }
            .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}

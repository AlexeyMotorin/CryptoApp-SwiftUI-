//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 27.01.2024.
//

import SwiftUI

struct CoinImageView: View {

    @StateObject var viewModel: CoinImageViewModel

    init(coinModel: CoinModel) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coinModel: coinModel))
    }

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: L10.questionmark)
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coinModel: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


//
//  DetailView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 25.02.2024.
//

import SwiftUI

struct DetailView: View {

    @StateObject private var viewModel: DetailViewModel

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private let spacing: CGFloat = 30

    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Hi")
                    .frame(height: 150)

                overviewTitle
                Divider()
                overviewGrid

                additionalTitle
                Divider()
                additionalGride
            }
            .padding()

        }
        .navigationTitle(viewModel.coin.name)
    }
}

// MARK: Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

// MARK: Components
private extension DetailView {

    var overviewTitle: some View {
        Text(L10.overview)
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    var additionalTitle: some View {
        Text(L10.additionalDetails)
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }

    var additionalGride: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            })
    }
}

//
//  HomeView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var viewModel: HomeViewModel

    @State private var showPortfolio = true

    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()

            // content layer
            VStack {
                homeViewHeader
                SearchBarView(searchText: $viewModel.searchText)
                columnsTitle

                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }

                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
            .hideKeyboardWhenTappedAround()
            .hideKeyboardWhenScrolling()
        }
    }
}

// MARK: Components
private extension HomeView {
    var homeViewHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? L10.plus : L10.info)
                .animation(.none, value: showPortfolio)
                .background {
                    CircleButtonAnimationView(showAnimation: $showPortfolio)
                }
            Spacer()
            Text(showPortfolio ? L10.homeHeaderTextPortfolio : L10.homeHeaderTextPrice)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: L10.chevronRight)
                .rotationEffect(Angle(degrees: showPortfolio ?  180 : 0))
                .onTapGesture {
                    withAnimation(.bouncy) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }

    var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) {
                CoinRowView(coin: $0, showHoldingsColumn: false)
            }
        }
        .listStyle(.plain)
    }

    var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) {
                CoinRowView(coin: $0, showHoldingsColumn: true)
            }
        }
        .listStyle(.plain)
    }

    var columnsTitle: some View {
        HStack {
            Text(L10.coinTitle)
            Spacer()
            if showPortfolio {
                Text(L10.holdingTitle)
            }
            Text(L10.priceTitle)
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

// MARK: Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeVM)
            .navigationBarHidden(true)
    }
}

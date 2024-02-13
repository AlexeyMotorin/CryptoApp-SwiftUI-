//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 08.02.2024.
//

import SwiftUI

struct PortfolioView: View {

    @EnvironmentObject private var viewModel: HomeViewModel

    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList

                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle(L10.portfolioViewTitle)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                   trailingNavBarButton
                }
            }
        }
    }
}

// MARK: Components
private extension PortfolioView {

    var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                        Color.theme.green : .clear,
                                        lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }

    var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text(L10.currentPriceOf(selectedCoin?.symbol.uppercased()))
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text(L10.amountHolding)
                Spacer()
                TextField(L10.placeholderAmountHolding, text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text(L10.currentValue)
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(nil, value: UUID())
        .padding()
        .font(.headline)
    }

    var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: L10.checkMark)
                .opacity(showCheckMark ? 1 : 0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text(L10.saveButtonTitle.uppercased())
            })
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1 : 0)

        }
        .font(.headline)
    }
}


// MARK: Methods
private extension PortfolioView {
    func getCurrentValue() -> Double {
        guard let quantity = Double(quantityText) else { return 0 }
        return quantity * (selectedCoin?.currentPrice ?? 0)
    }

    func saveButtonPressed() {
//        guard let coin = selectedCoin else { return }

        //save portfolio

        // show checkMark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }

        //hide keyboard
        UIApplication.shared.endEditing()

        // hide checkMark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                showCheckMark = false 
            }
        }
    }

    func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}

// MARK: Preview
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
       PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

//
//  DetailView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 25.02.2024.
//

import SwiftUI

struct DetailView: View {

    @StateObject private var viewModel: DetailViewModel

    init(coinId: String) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coinId: coinId))
    }

    var body: some View {
        Text(viewModel.coinDetail?.description?.en ?? "Error")
    }
}

// MARK: Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coinId: "bitcoin")
    }
}

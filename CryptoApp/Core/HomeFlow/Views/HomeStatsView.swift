//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 06.02.2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var showPortfolio: Bool

    var body: some View {
        HStack {
            ForEach(viewModel.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, 
               alignment: showPortfolio ? .trailing : .leading)
    }
}

// MARK: Preview
struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}

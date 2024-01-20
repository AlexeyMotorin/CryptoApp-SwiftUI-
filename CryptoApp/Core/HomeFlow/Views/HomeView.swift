//
//  HomeView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false

    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()

            // content layer
            VStack {
                homeViewHeader
                Spacer(minLength: 0)
            }
        }
    }
}

// MARK: Components
private extension HomeView {
    var homeViewHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? StringConstants.plus : StringConstants.info)
                .animation(.none, value: showPortfolio)
                .background {
                    CircleButtonAnimationView(showAnimation: $showPortfolio)
                }
            Spacer()
            Text(showPortfolio ? StringConstants.homeHeaderTextPortfolio : StringConstants.homeHeaderTextPrice)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: StringConstants.chevronRight)
                .rotationEffect(Angle(degrees: showPortfolio ?  180 : 0))
                .onTapGesture {
                    withAnimation(.bouncy) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

// MARK: Preview
#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}

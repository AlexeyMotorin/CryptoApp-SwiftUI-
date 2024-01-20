//
//  HomeView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()

            // content layer
            VStack {
                HStack {
                    CircleButtonView(iconName: StringConstants.info)
                    Spacer()
                    Text("Header")
                    Spacer()
                    CircleButtonView(iconName: StringConstants.chevronRight)
                }
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}

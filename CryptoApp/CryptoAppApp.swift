//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

@main
struct CryptoAppApp: App {

    @StateObject private var viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(viewModel)
                    .navigationBarHidden(true)
            }
        }
    }
}

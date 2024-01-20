//
//  Color+extension.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

extension Color {
    static let theme = CryptoColor()
}

struct CryptoColor {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenCrypto")
    let red = Color("RedCrypto")
    let secondaryText = Color("SecondaryTextColor")
}

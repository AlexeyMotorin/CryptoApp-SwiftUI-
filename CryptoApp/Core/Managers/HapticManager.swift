//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 23.02.2024.
//
 
import SwiftUI

final class HapticManager {
    static let shared = HapticManager()

    private init() {}

    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

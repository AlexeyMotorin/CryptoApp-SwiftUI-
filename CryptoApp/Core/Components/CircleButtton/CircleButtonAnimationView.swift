//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var showAnimation: Bool

    var body: some View {
       Circle()
            .stroke(lineWidth: 5)
            .scale(showAnimation ? 1 : 0)
            .opacity(showAnimation ? 0 : 1)
            .animation(showAnimation ? .easeOut(duration: 0.3) : .none, value: showAnimation)
            .onAppear {
                showAnimation.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimationView(showAnimation: .constant(false))
}

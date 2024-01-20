//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 20.01.2024.
//

import SwiftUI

struct CircleButtonView: View {

    let iconName: String

    var body: some View {
       Image(systemName:  iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background {
                Circle()
                    .foregroundColor(Color.theme.background)
            }
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircleButtonView(iconName: "heart.fill")
                .colorScheme(.dark)
            CircleButtonView(iconName: "heart.fill")
                .colorScheme(.light)
        }
        .previewLayout(.sizeThatFits)
    }
}

//
//  XmarkButton.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 08.02.2024.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.dismiss) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode()
        }, label: {
            Image(systemName: L10.xmark)
                .font(.headline)
        })
    }
}

#Preview {
    XmarkButton()
}

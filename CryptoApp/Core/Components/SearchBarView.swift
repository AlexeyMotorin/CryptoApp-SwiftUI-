//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 02.02.2024.
//

import SwiftUI

struct SearchBarView: View {

    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: L10.magnifyingglass)
                .foregroundColor(
                    searchText.isEmpty ?  Color.theme.secondaryText : Color.theme.accent
                )
            TextField(L10.searchBarPlaceholder, text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: L10.xmarkCircleFill)
                        .padding()
                        .offset(x: 10.0)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            searchText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0.0, y: 0.0)
        }
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}

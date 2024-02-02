//
//  HideKeybordWhenScrollingModifier.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 02.02.2024.
//

import SwiftUI

struct HideKeyboardWhenScrollingModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollDismissesKeyboard(.immediately)
        } else {
            content
                .simultaneousGesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.endEditing()
                }))
        }
    }
}

extension View {
    func hideKeyboardWhenScrolling() -> some View {
        self.modifier(HideKeyboardWhenScrollingModifier())
    }

    func hideKeyboardWhenTappedAround() -> some View  {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

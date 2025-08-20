//
//  SwiftUIView.swift
//  FormValidationApp
//
//  Created by ladans on 19/08/25.
//

import SwiftUI

extension View {
    func textfieldStyle(
        isError: Bool = false,
        isFocused: Bool = false,
    ) -> some View {
        modifier(
            TextfieldStyle(
                isError: isError,
                isFocused: isFocused,
            )
        )
    }
    
    func textfieldLabelStyle() -> some View {
        modifier(LabelStyle())
    }
}

struct TextfieldStyle: ViewModifier {
    var isError: Bool = false
    var isFocused: Bool = false
    
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .padding(10)
            .foregroundStyle(isError ? .red : .black)
            .background {
                if isFocused && !isError {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                        .stroke(.blue, style: .init(lineWidth: 2))
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                        .stroke(isError ? .red : .gray.opacity(0.7), style: .init(lineWidth: isError ? 2 : 1))
                }
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isFocused)
    }
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.gray)
            .font(.title2)
    }
}

//
//  Modifiers.swift
//  SFMemory
//
//  Created by Vincent Caronnet on 03/10/2020.
//

import SwiftUI

struct MainViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 32, weight: .medium, design: .rounded))
            .foregroundColor(Color.blue)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
    }
}

extension View {
    func customButton(_ color: Color) -> some View {
        return self
            .padding(.horizontal, 10.0)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .customBorder(color)
    }
    func customBorder(_ color: Color) -> some View {
        return self
        .overlay(
            RoundedRectangle(cornerRadius: 3.0)
                .stroke(color, lineWidth: 3.0)
        )
        .foregroundColor(color)
    }
    func customBackground(_ color: Color) -> some View {
        return self
        .overlay(
            RoundedRectangle(cornerRadius: 3.0)
                .fill(color)
        )
        .foregroundColor(color)
    }
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}

struct MatchedCardViewBuilder <Content: View>: View {
    var content: Content
    let cardLength: CGFloat
    let color: Color
    
    init(
        @ViewBuilder content: () -> Content,
        cardLength: CGFloat,
        color: Color
    ) {
        self.content = content()
        self.cardLength = cardLength
        self.color = color
    }
    
    var body: some View {
        content
            .font(.system(size: 36, weight: .regular, design: .rounded))
            .frame(width: abs(cardLength), height: abs(cardLength))
            .aspectRatio(1, contentMode: .fit)
            .customBorder(color)
    }
}

//
//  GlacialEffect.swift
//  Cenify
//
//  Created by Samy Mehdid on 11/12/2023.
//

import SwiftUI

struct GlacialEffect: ViewModifier {
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color("CNGlacial").opacity(0.4), location: 0),
                        .init(color: Color("CNGlacial").opacity(0.1), location: 1)]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading)
                .cornerRadius(cornerRadius)
                .background(.ultraThinMaterial)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color("CNGlacial").opacity(0.4), location: 0),
                            .init(color: Color("CNGlacial").opacity(0.1), location: 1)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing), lineWidth: 1)
            }
    }
}


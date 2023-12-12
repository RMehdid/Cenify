//
//  CNLabel.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import SwiftUI

struct CNLabel: View {
    
    private var string: String
    private var alwaysWhite: Bool
    
    init(_ string: String, alwaysWhite: Bool = false) {
        self.string = string
        self.alwaysWhite = alwaysWhite
    }
    
    var body: some View {
        ZStack{
            Text(string)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(alwaysWhite ? Color.white : Color.primary)
                .padding(.vertical)
                .frame(minWidth: 68)
                .padding(.horizontal, 4)
                .background(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: .infinity)
                        .strokeBorder(
                            LinearGradient(
                                colors: [Color("CNGlacial"), .clear],
                                startPoint: .topTrailing,
                                endPoint: .bottomLeading
                            ),
                            lineWidth: 1
                        )
                }
                .cornerRadius(.infinity)
        }
    }
}

#Preview {
    CNLabel("Released")
}

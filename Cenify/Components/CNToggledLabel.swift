//
//  CNToggledLabel.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import SwiftUI

struct CNToggledLabel: View {
    
    private let genre: GenreItem
    private let isSelected: Bool
    private let didToggle: (GenreItem) -> Void
    
    init(_ genre: GenreItem, isSelected: Bool, didToggle: @escaping (GenreItem) -> Void) {
        self.genre = genre
        self.isSelected = isSelected
        self.didToggle = didToggle
    }
    
    var body: some View {
        Button{
            didToggle(genre)
        } label: {
            ZStack{
                if isSelected {
                    Text(genre.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color("CNBack"))
                        .padding(.vertical)
                        .frame(minWidth: 68)
                        .padding(.horizontal, 4)
                        .background(Color("CNGlacial"))
                } else {
                    Text(genre.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.primary)
                        .padding(.vertical)
                        .frame(minWidth: 68)
                        .padding(.horizontal, 4)
                        .background(.ultraThinMaterial)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: .infinity)
                    .strokeBorder(
                        .primary,
                        lineWidth: 2
                    )
            }
            .cornerRadius(.infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

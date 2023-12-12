//
//  CNToggledLabel.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import SwiftUI

struct CNLabel: View {
    
    private var string: String?
    private let genre: Genre
    private let isSelected: Bool
    private let isAlwaysWhite: Bool
    private let didToggle: ((Genre) -> Void)?
    
    
    init(_ genre: Genre, isSelected: Bool, didToggle: @escaping (Genre) -> Void) {
        self.genre = genre
        self.isSelected = isSelected
        self.didToggle = didToggle
        self.isAlwaysWhite = false
    }
    
    init(_ genre: Genre) {
        self.genre = genre
        self.isSelected = false
        self.isAlwaysWhite = false
        self.didToggle = nil
    }
    
    init(string: String) {
        self.string = string
        self.genre = Genre(id: 0, name: "")
        self.isSelected = false
        self.isAlwaysWhite = true
        self.didToggle = nil
    }
    
    var body: some View {
        Button{
            didToggle?(genre)
        } label: {
            ZStack{
                if isSelected {
                    Text(genre.name)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color("CNBack"))
                        .padding(.vertical)
                        .frame(minWidth: 68)
                        .padding(.horizontal, 4)
                        .background(Color("CNGlacial"))
                } else {
                    Text(string ?? genre.name)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(isAlwaysWhite ? Color.white : Color.primary)
                        .padding(.vertical)
                        .frame(minWidth: 68)
                        .padding(.horizontal, 4)
                        .background(.ultraThinMaterial)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: .infinity)
                    .strokeBorder(
                        isAlwaysWhite ? .white : .primary,
                        lineWidth: 2
                    )
            }
            .cornerRadius(.infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

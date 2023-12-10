//
//  Text.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

extension Text {
    func font(_ color: Color, _ font: Font.SFProDisplay, _ size: CGFloat) -> Text {
        switch font {
        case .regular:
            return self
                .font(.custom(Font.SFProDisplay.regular.rawValue, size: size))
                .foregroundColor(color)
        case .medium:
            return self
                .font(.custom(Font.SFProDisplay.medium.rawValue, size: size))
                .foregroundColor(color)
        case .semiBold:
            return self
                .font(.custom(Font.SFProDisplay.semiBold.rawValue, size: size))
                .foregroundColor(color)
        case .bold:
            return self
                .font(.custom(Font.SFProDisplay.bold.rawValue, size: size))
                .foregroundColor(color)
        }
    }
}

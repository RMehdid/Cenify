//
//  ColorScheme.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import SwiftUI

extension Optional where Wrapped == ColorScheme {
    mutating func toggleScheme(availableScheme: ColorScheme) {
        switch self {
        case .light:
            self = .dark
        case .dark:
            self = .light
        case nil:
            self?.toggleScheme(availableScheme: availableScheme)
        default: break
        }
    }
}

extension ColorScheme {
    mutating func toggleScheme(availableScheme: ColorScheme) {
        switch self {
        case .light:
            self = .dark
        case .dark:
            self = .light
        default: break
        }
    }
}

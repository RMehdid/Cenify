//
//  Double.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

extension Double {
    var toString: String {
        if self > Double(Int(self)) {
            return String(format: "%.2f", self)
        } else {
            return String(format: "%.0f", self)
        }
    }
}

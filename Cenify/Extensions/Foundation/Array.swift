//
//  Array.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import Foundation

extension Array where Element == Genre {
    func stringValue(_ separator: String) -> String {
        return self.map { String($0.id) }.joined(separator: separator)
    }
}

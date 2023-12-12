//
//  Array.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import Foundation

extension Array where Element == GenreItem {
    func stringValue(_ separator: String) -> String? {
        guard var string = self.first?.rawValue else {
            return nil
        }
        
        for item in self {
            string.append(separator + item.rawValue)
        }
        
        return string
    }
}

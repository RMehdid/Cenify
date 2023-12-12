//
//  UIApplication.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

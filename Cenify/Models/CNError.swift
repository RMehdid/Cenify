//
//  CNError.swift
//  Cenify
//
//  Created by Samy Mehdid on 11/12/2023.
//

import SwiftUI

enum CNError: Error {
    case badReponse
    case badUrl
    case timout
    case forbidden
    case unknown
    
    @ViewBuilder
    func errorView() -> some View {
        switch self {
        case .badReponse:
            FailView(iconName: "ic_decoding", message: "Decoding error")
        case .badUrl:
            FailView(iconName: "ic_code_error", message: "Bad url")
        case .timout:
            FailView(iconName: "ic_network_error", message: "No internet connection")
        case .forbidden:
            FailView(iconName: "ic_profile_error", message: "Uou don’t have the right to be here")
        case .unknown:
            FailView(iconName: "ic_decoding", message: "Something went wrong")
        }
    }
}

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
            DecodingError()
        case .badUrl:
            BadUrl()
        case .timout:
            NetworkError()
        case .forbidden:
            ForbiddenError()
        case .unknown:
            FailView(iconName: "ic_decoding", message: "Something went wrong")
        }
    }
}

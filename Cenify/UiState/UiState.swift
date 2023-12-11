//
//  UiState.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

enum UiState<Model> {
    case empty
    case loading
    case success(Model)
    case failure(CNError)
}

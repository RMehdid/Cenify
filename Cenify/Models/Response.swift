//
//  Response.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import Foundation

struct Response<Model: Decodable>: Decodable {
    let results: Model
}

struct GenreResponse<Model: Decodable>: Decodable {
    let genres: Model
}

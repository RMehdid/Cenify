//
//  Movie.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

struct Response<Model: Decodable>: Decodable {
    let results: Model
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let release_date: String
    let overview: String
    let poster_path: String
}

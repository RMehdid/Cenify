//
//  MovieDetails.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

struct MovieDetails: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let release_date: String
    let overview: String
    let poster_path: String
    let vote_average: Double
    let status: String
    let original_language: String
    
    func imageLoader(size: String) -> String {
        guard let imageBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ImageBaseUrl") as? String else {
            return ""
        }
        
        return imageBaseUrl + size + poster_path
    }
}

//
//  Season.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import Foundation

struct Season: Decodable, Identifiable {
    let air_date: String?
    let episode_count: Int
    let id: Int
    let name: String
    let overview: String
    let poster_path: String?
    let season_number: Int
    let vote_average: Double
    
    func imageLoader(size: String) -> String {
        guard let poster_path = poster_path, let imageBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ImageBaseUrl") as? String else {
            return ""
        }
        
        return imageBaseUrl + size + poster_path
    }
}

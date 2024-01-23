//
//  Episode.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import Foundation

struct Episode: Decodable, Identifiable {
    let air_date: String
    let episode_number: Int
    let id: Int
    let name: String
    let overview: String
    let still_path: String?
    let vote_average: Double
    
    func imageLoader(size: String) -> String {
        guard let still_path = still_path, let imageBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ImageBaseUrl") as? String else {
            return ""
        }
        
        return imageBaseUrl + size + still_path
    }
}

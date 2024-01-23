//
//  TVShow.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import Foundation

struct TVShow: MediaProtocol {
    let id: Int
    let title: String
    let date: String
    let poster_path: String?
    let vote_average: Double
    
    func imageLoader(size: String) -> String? {
        guard let poster_path = poster_path, let imageBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ImageBaseUrl") as? String else {
            return nil
        }
        
        return imageBaseUrl + size + poster_path
    }
    
    static let dumbForShimmer = TVShow(id: 0, title: "dumb title", date: "2020", poster_path: "/hdgfhjs.png", vote_average: 7.7)
    
    enum CodingKeys: String, CodingKey {
        case id, poster_path, vote_average
        case title = "name"
        case date = "first_air_date"
    }
}

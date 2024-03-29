//
//  MovieDetails.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

struct MovieDetails: MediaDetailProtocol {
    
    let id: Int
    let title: String
    let release_date: String
    let overview: String
    let poster_path: String?
    let vote_average: Double
    let status: String
    let original_language: String
    let genres: [Genre]
    
    func imageLoader(size: String) -> String {
        guard let poster_path = poster_path, let imageBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ImageBaseUrl") as? String else {
            return ""
        }
        
        return imageBaseUrl + size + poster_path
    }
    
    static let dumbForShimmer = MovieDetails(id: 0, title: "dumb movie name", release_date: "2010-10-10", overview: "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Reiciendis, quaerat molestiae eveniet odit animi veritatis eligendi necessitatibus inventore est fuga ex consequatur modi iusto, ipsum, velit tempora ducimus dicta. Velit.", poster_path: "/jhfgjhsdfbsdjhf.png", vote_average: 7.77, status: "RELEASED", original_language: "EN", genres: [Genre(id: 1, name: "Fantasy"), Genre(id: 2, name: "Advanture"), Genre(id: 3, name: "Science Fiction"), Genre(id: 4, name: "Action")])
}

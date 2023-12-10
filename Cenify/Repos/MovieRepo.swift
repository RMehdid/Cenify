//
//  MovieRepo.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

class MovieRepo {
    private enum Urls: String {
        case moviesList = "/discover/movie"
        case getDetails = "rider/upload"
    }
    
    static func getMovies(page: Int) async throws -> [Movie] {
        return try await NetworkManager.shared.get(endpoint: Urls.moviesList.rawValue + "?page=\(page)")
    }
    
    
}

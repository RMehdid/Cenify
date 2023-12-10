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
        case movieDetails = "/movie/{{id}}"
    }
    
    static func getMovies(page: Int) async throws -> Response<[Movie]> {
        return try await NetworkManager.shared.get(endpoint: Urls.moviesList.rawValue + "?page=\(page)")
    }
    
    static func getMovieDetail(_ id: Int) async throws -> MovieDetails {
        return try await NetworkManager.shared.get(endpoint: Urls.movieDetails.rawValue.replacingOccurrences(of: "{{id}}", with: "\(id)"))
    }
}

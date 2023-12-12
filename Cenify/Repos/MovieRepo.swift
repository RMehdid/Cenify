//
//  MovieRepo.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

class MovieRepo {
    private enum Endpoint: String {
        case moviesList = "/discover/movie"
        case movieDetails = "/movie/{{id}}"
        case searchMovies = "/search/movie"
    }
    
    static func getMovies(page: Int) async throws -> Response<[Movie]> {
        let body = [
            "page": page
        ]
        
        return try await NetworkManager.shared.get(endpoint: Endpoint.moviesList.rawValue, query: body)
    }
    
    static func getMovieDetail(_ id: Int) async throws -> MovieDetails {
        return try await NetworkManager.shared.get(endpoint: Endpoint.movieDetails.rawValue.replacingOccurrences(of: "{{id}}", with: "\(id)"))
    }
    
    static func searchMovies(query: String, page: Int) async throws -> Response<[Movie]> {
        let body: [String: Any] = [
            "query": query,
            "page": page
        ]
        
        return try await NetworkManager.shared.get(endpoint: Endpoint.searchMovies.rawValue, query: body)
    }
}

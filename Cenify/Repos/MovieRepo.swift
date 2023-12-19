//
//  MovieRepo.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import Foundation

class MovieRepo: MediaRepo {
    private enum Endpoint: String {
        case moviesList = "/discover/movie"
        case movieDetails = "/movie/{{id}}"
        case searchMovies = "/search/movie"
        case genresList = "/genre/movie/list"
    }
    
    static func getMovies(genres: [Genre] = [], page: Int) async throws -> Response<[Movie]> {
        
        return try await self.getMedia(endpoint: Endpoint.moviesList.rawValue, genres: genres, page: page)
    }
    
    static func getMovieDetail(_ id: Int) async throws -> MovieDetails {
        return try await NetworkManager.shared.get(endpoint: Endpoint.movieDetails.rawValue.replacingOccurrences(of: "{{id}}", with: "\(id)"))
    }
    
    static func searchMovies(query: String) async throws -> Response<[Movie]> {
        
        return try await self.searchMedia(endpoint: Endpoint.searchMovies.rawValue, query: query)
    }
    
    static func getGenres() async throws -> GenreResponse<[Genre]> {
        return try await self.getGenres(endpoint: Endpoint.genresList.rawValue)
    }
}

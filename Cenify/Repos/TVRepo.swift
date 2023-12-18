//
//  TVRepo.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import Foundation

class TVRepo: MediaRepo {
    private enum Endpoint: String {
        case tvShowList = "discover/tv"
        case searchTvShows = "/search/tv"
        case genresList = "/genre/tv/list"
    }
    
    static func getTvShows(genres: [Genre] = [], page: Int) async throws -> Response<[TVShow]> {
        let body : [String: Any] = [
            "page": page,
            "with_genres": genres.stringValue(",")
        ]
        
        return try await self.getMedia(endpoint: Endpoint.tvShowList.rawValue, genres: genres, page: page)
    }
    
    static func searchTvShows(query: String) async throws -> Response<[TVShow]> {
        let body: [String: Any] = [
            "query": query
        ]
        
        return try await NetworkManager.shared.get(endpoint: Endpoint.searchTvShows.rawValue, query: body)
    }
    
    static func getGenres() async throws -> GenreResponse<[Genre]> {
        return try await self.getGenres(endpoint: Endpoint.genresList.rawValue)
    }
}

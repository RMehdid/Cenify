//
//  TVRepo.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import Foundation

class TVRepo: MediaRepo {
    private enum Endpoint: String {
        case tvShowList = "/discover/tv"
        case tvShowDetails = "/tv/{{id}}"
        case searchTvShows = "/search/tv"
        case genresList = "/genre/tv/list"
    }
    
    static func getTvShows(genres: [Genre] = [], page: Int) async throws -> Response<[TVShow]> {
        
        return try await self.getMedia(endpoint: Endpoint.tvShowList.rawValue, genres: genres, page: page)
    }
    
    static func getTvShowDetail(_ id: Int) async throws -> TvShowDetail {
        
        return try await self.getMediaDetail(endpoint: Endpoint.tvShowDetails.rawValue, id: id)
    }
    
    static func searchTvShows(query: String) async throws -> Response<[TVShow]> {
        
        return try await self.searchMedia(endpoint: Endpoint.searchTvShows.rawValue, query: query)
    }
    
    static func getGenres() async throws -> GenreResponse<[Genre]> {
        return try await self.getGenres(endpoint: Endpoint.genresList.rawValue)
    }
}

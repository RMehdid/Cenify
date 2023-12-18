//
//  MediaRepo.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

class MediaRepo {
    
    static func getMedia<Model: MediaProtocol>(endpoint: String, genres: [Genre] = [], page: Int) async throws -> Response<[Model]> {
        let body : [String: Any] = [
            "page": page,
            "with_genres": genres.stringValue(",")
        ]
        
        return try await NetworkManager.shared.get(endpoint: endpoint, query: body)
    }
    
    static func searchMedia<Model: MediaProtocol>(endpoint: String, query: String) async throws -> Response<[Model]> {
        let body: [String: Any] = [
            "query": query
        ]
        
        return try await NetworkManager.shared.get(endpoint: endpoint, query: body)
    }
    
    static func getGenres(endpoint: String) async throws -> GenreResponse<[Genre]> {
        return try await NetworkManager.shared.get(endpoint: endpoint)
    }
}

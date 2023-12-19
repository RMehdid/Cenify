//
//  NetworkManager.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    
    public private(set) static var shared = NetworkManager()
    
    let session = Session(eventMonitors: [NetworkLogger()])
    
    private var baseUrl: String {
        return Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String ?? ""
    }
    
    private var token: String {
        return Bundle.main.object(forInfoDictionaryKey: "Token") as? String ?? ""
    }
    
    private var headers: HTTPHeaders {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
    
    private let timout: Double = 15
    
    public func get<Model: Decodable>(endpoint: String, query: [String: Any]? = nil) async throws -> Model {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(
                baseUrl + endpoint,
                parameters: query,
                headers: headers,
                requestModifier: { $0.timeoutInterval = self.timout }
            )
            .responseData { response in
                
                guard let status = response.response?.statusCode else {
                    continuation.resume(throwing: CNError.badReponse)
                    return
                }
                
                switch status {
                case 404:
                    continuation.resume(throwing: CNError.badUrl)
                case 400...499:
                    continuation.resume(throwing: CNError.forbidden)
                case 200...299:
                    switch response.result {
                    case .success(let res):
                        do {
                            let decodedModel = try JSONDecoder().decode(Model.self, from: res)
                            continuation.resume(returning: decodedModel)
                        } catch {
                            continuation.resume(throwing: CNError.badReponse)
                        }
                    case .failure:
                        continuation.resume(throwing: CNError.timout)
                    }
                
                default: continuation.resume(throwing: CNError.unknown)
                }
            }
        }
    }
}

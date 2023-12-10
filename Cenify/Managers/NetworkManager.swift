//
//  NetworkManager.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation
import Alamofire

enum CNError: Error {
    case badReponse
    case badUrl
    case timout
    case forbidden
    case unknown
}

actor NetworkManager: GlobalActor {
    
    public private(set) static var shared = NetworkManager()
    
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
        
        debugPrint("http:url: \(baseUrl)\(endpoint)")
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                baseUrl + endpoint,
                parameters: query,
                headers: headers,
                requestModifier: { $0.timeoutInterval = self.timout }
            )
            .responseData { response in
                debugPrint("http:res: \(response.debugDescription)")
                
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
                        continuation.resume(throwing: CNError.badReponse)
                    }
                
                default: continuation.resume(throwing: CNError.unknown)
                }
            }
        }
    }
}

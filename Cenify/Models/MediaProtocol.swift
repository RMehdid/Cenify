//
//  MediaProtocol.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import Foundation

protocol MediaProtocol: Decodable, Identifiable {
    var id: Int { get }
    var title: String { get }
    var poster_path: String? { get }
    var vote_average: Double { get }
    
    func imageLoader(size: String) -> String?
}

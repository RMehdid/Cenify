//
//  MovieCard.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI
import Kingfisher

struct MovieCard: View {
    
    let movie: Movie
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack{
            HStack{
                if let url = URL(string: movie.imageLoader(size: "w500")) {
                    KFImage(url)
                }
            }
            Rectangle()
                .frame(height: 2)
                .opacity(0.4)
        }
    }
}

#Preview {
    MovieCard(Movie(id: 823282, title: "Movie name", release_date: "2022", overview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.", poster_path: "/sEaLO9s7CIN3fjz8R3Qksum44en.jpg", vote_average: 7.7))
}

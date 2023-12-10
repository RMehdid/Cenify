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
        VStack(alignment: .leading, spacing: 16){
            HStack{
                if let url = URL(string: movie.imageLoader(size: "w500")) {
                    KFImage(url)
                        .resizable()
                        .placeholder { progress in
                            Color.gray
                        }
                        .frame(width: 70, height: 100)
                        .cornerRadius(8)
                }
                
                VStack(alignment: .leading, spacing: 16){
                    VStack(alignment: .leading, spacing: 6){
                        Text(movie.title)
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.leading)
                        Text(movie.release_date)
                            .font(.system(size: 12, weight: .medium))
                    }
                    
                    HStack(spacing: 6){
                        Image("ic_star")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                        
                        Text(movie.vote_average.toString)
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
            }
            .padding(.horizontal, 8)
            Rectangle()
                .frame(height: 2)
                .opacity(0.4)
        }
    }
}

#Preview {
    MovieCard(Movie(id: 823282, title: "Movie name", release_date: "2022", poster_path: "/sEaLO9s7CIN3fjz8R3Qksum44en.jpg", vote_average: 7.7))
}

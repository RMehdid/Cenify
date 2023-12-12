//
//  MovieCard.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI
import Kingfisher

struct MovieCard: View {
    
    private var movie: Movie?
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    init() {}
    
    var body: some View {
        HStack(spacing: 10){
            if let url = URL(string: movie?.imageLoader(size: "w500") ?? "") {
                KFImage(url)
                    .resizable()
                    .placeholder { progress in
                        Color.gray
                    }
                    .frame(width: 70, height: 100)
                    .cornerRadius(8)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 70, height: 100)
                    .redacted(reason: .placeholder)
            }
            
            VStack(alignment: .leading, spacing: 16){
                VStack(alignment: .leading, spacing: 6){
                    if let title = movie?.title {
                        Text(title)
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.leading)
                    } else {
                        Text(Movie.dumbForShimmer.title)
                            .redacted(reason: .placeholder)
                    }
                    
                    if let release_date = movie?.release_date {
                        Text(release_date)
                            .font(.system(size: 12, weight: .medium))
                    } else {
                        Text(Movie.dumbForShimmer.release_date)
                            .redacted(reason: .placeholder)
                    }
                }
                
                HStack(spacing: 6){
                    if let movie = movie {
                        Image("ic_star")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                    }
                    
                    if let vote_average = movie?.vote_average {
                        Text(vote_average.toString)
                            .font(.system(size: 14, weight: .semibold))
                    } else {
                        Text(Movie.dumbForShimmer.vote_average.toString)
                            .redacted(reason: .placeholder)
                    }
                }
            }
            .padding(8)
            Spacer()
        }
        .padding(10)
        .glacialEffect(8)
    }
}

#Preview {
    MovieCard()
}

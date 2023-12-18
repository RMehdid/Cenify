//
//  MovieCard.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI
import Kingfisher

struct MediaCard<T: MediaProtocol>: View {
    
    private var media: T?
    
    init(_ media: T) {
        self.media = media
    }
    
    init() {}
    
    var body: some View {
        HStack(spacing: 10){
            if let imageUrl = media?.imageLoader(size: "w500"), let url = URL(string: imageUrl) {
                KFImage(url)
                    .resizable()
                    .placeholder { progress in
                        Image("ic_movie_poster")
                    }
                    .frame(width: 70, height: 100)
                    .cornerRadius(8)
            } else {
                Image("ic_movie_poster")
                    .resizable()
                    .frame(width: 70, height: 100)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 16){
                VStack(alignment: .leading, spacing: 6){
                    if let title = media?.title {
                        Text(title)
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.leading)
                    } else {
                        Text(Movie.dumbForShimmer.title)
                            .redacted(reason: .placeholder)
                    }
                }
                
                HStack(spacing: 6){
                    if media != nil {
                        Image("ic_star")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                    }
                    
                    if let vote_average = media?.vote_average {
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
        .background(.ultraThinMaterial.tertiary)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

#Preview {
    MediaCard<Movie>()
}

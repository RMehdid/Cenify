//
//  EpisodeCard.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import SwiftUI
import Kingfisher

struct EpisodeCard: View {
    
    var episode: Episode?
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    init() {}
    
    var body: some View {
        HStack{
            ZStack{
                if let imageUrl = episode?.imageLoader(size: "w500"), let url = URL(string: imageUrl) {
                    KFImage(url)
                        .resizable()
                        .placeholder { progress in
                            Color.gray
                        }
                        .overlay{
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)), location: 0),
                                    .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)), location: 0.5),
                                    .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)), location: 1)]),
                                startPoint: .top,
                                endPoint: .bottom)
                        }
                        .frame(width: 60, height: 60)
                        .scaledToFill()
                        .cornerRadius(8)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray)
                        .frame(width: 60, height: 60)
                        .redacted(reason: .placeholder)
                }
            }
            
            VStack(alignment: .leading, spacing: 16){
                VStack(alignment: .leading, spacing: 6){
                    HStack{
                        if let title = episode?.name {
                            Text(title)
                                .font(.system(size: 20, weight: .bold))
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(Movie.dumbForShimmer.title)
                                .redacted(reason: .placeholder)
                        }
                        Spacer()
                        HStack(spacing: 6){
                            if episode != nil {
                                Image("ic_star")
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 16, height: 16)
                            }
                            
                            if let vote_average = episode?.vote_average {
                                Text(vote_average.toString)
                                    .font(.system(size: 12, weight: .semibold))
                            } else {
                                Text(Movie.dumbForShimmer.vote_average.toString)
                                    .redacted(reason: .placeholder)
                            }
                        }
                    }
                    if let date = episode?.air_date {
                        Text(date)
                            .font(.system(size: 12, weight: .medium))
                    } else {
                        Text(Movie.dumbForShimmer.date)
                            .redacted(reason: .placeholder)
                    }
                    
                    if let overview = episode?.overview {
                        Text(overview.prefix(60) + "...")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 12, weight: .medium))
                    } else {
                        Text(Movie.dumbForShimmer.date)
                            .redacted(reason: .placeholder)
                    }
                }
            }
        }
        .padding(4)
        .background(.ultraThinMaterial.tertiary)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

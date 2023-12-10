//
//  MovieDetailsView.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let id: Int
    
    @StateObject private var model = Model()
    
    init(_ id: Int) {
        self.id = id
    }
    
    var body: some View {
        ZStack{
            switch model.movieDetailsUiState {
            case .empty:
                EmptyView()
            case .loading:
                EmptyView()
            case .success(let movieDetails):
                VStack{
                    PosterCard(imageUrl: movieDetails.imageLoader(size: "w500"), movieStatus: movieDetails.status, originalLanguage: movieDetails.original_language.uppercased())
                    VStack(alignment: .leading){
                        HStack{
                            Text(movieDetails.title)
                            Spacer()
                            HStack{
                                Image("ic_star")
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 24, height: 24)
                                
                                Text(movieDetails.vote_average.toString)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        Text(movieDetails.release_date)
                            .font(.system(size: 16, weight: .regular))
                    }
                    
                    Text(movieDetails.overview)
                        .font(.system(size: 14, weight: .regular))
                }
            case .failure(let error):
                EmptyView()
            }
        }
        .onAppear {
            model.getMovieDetail(id)
        }
    }
}

#Preview {
    MovieDetailsView(466420)
}

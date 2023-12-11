//
//  MovieDetailsView.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    
    private let id: Int
    
    @Binding private var selectedScheme: ColorScheme?
    
    @StateObject private var model = Model()
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) private var colorScheme
    
    init(_ id: Int, selectedScheme: Binding<ColorScheme?>) {
        self.id = id
        self._selectedScheme = selectedScheme
    }
    
    var body: some View {
        ZStack{
            switch model.movieDetailsUiState {
            case .empty, .idle:
                EmptyView()
            case .loading:
                VStack{
                    PosterCard()
                        .redacted(reason: .placeholder)
                        .shimmering()
                    VStack(alignment: .leading){
                        HStack{
                            Text(MovieDetails.dumbForShimmer.title)
                                .redacted(reason: .placeholder)
                                .shimmering()
                            
                            Spacer()
                            HStack{
                                Image("ic_star")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .redacted(reason: .placeholder)
                                    .shimmering()
                                
                                Text(MovieDetails.dumbForShimmer.vote_average.toString)
                                    .redacted(reason: .placeholder)
                                    .shimmering()
                            }
                        }
                        Text(MovieDetails.dumbForShimmer.release_date)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    
                    Text(MovieDetails.dumbForShimmer.overview)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
            case .success(let movieDetails):
                VStack{
                    PosterCard(imageUrl: movieDetails.imageLoader(size: "w500"), movieStatus: movieDetails.status, originalLanguage: movieDetails.original_language.uppercased(), toggleScheme: toggleScheme)
                    VStack(alignment: .leading){
                        HStack{
                            Text(movieDetails.title)
                                .font(.system(size: 32, weight: .bold))
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
                error.errorView()
            }
        }
        .padding(.horizontal)
        .onAppear {
            model.getMovieDetail(id)
        }
        .navigationBarHidden(true)
        .backgroundEffect()
        .backOnSwipe(presentationMode: presentationMode)
    }
    
    private func toggleScheme() {
        withAnimation {
            switch selectedScheme {
            case .light:
                self.selectedScheme = .dark
            case .dark:
                self.selectedScheme = .light
            case nil:
                switch colorScheme {
                case .light:
                    self.selectedScheme = .dark
                case .dark:
                    self.selectedScheme = .light
                default: break
                }
            default: break
            }
        }
    }
}

#Preview {
    MovieDetailsView(466420, selectedScheme: .constant(.dark))
}

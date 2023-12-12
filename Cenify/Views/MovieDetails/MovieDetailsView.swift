//
//  MovieDetailsView.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI
import Kingfisher

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
                VStack(spacing: 16){
                    posterCard(movieDetails: nil)
                    
                    VStack(alignment: .leading, spacing: 16){
                        HStack{
                            ForEach(MovieDetails.dumbForShimmer.genres){ genre in
                                CNLabel(genre)
                                    .redacted(reason: .placeholder)
                            }
                        }
                        HStack{
                            Text(MovieDetails.dumbForShimmer.title)
                                .redacted(reason: .placeholder)
                            
                            Spacer()
                            HStack{
                                Image("ic_star")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .redacted(reason: .placeholder)
                                
                                Text(MovieDetails.dumbForShimmer.vote_average.toString)
                                    .redacted(reason: .placeholder)
                            }
                        }
                        Text(MovieDetails.dumbForShimmer.release_date)
                            .redacted(reason: .placeholder)
                    }
                    
                    Text(MovieDetails.dumbForShimmer.overview)
                        .redacted(reason: .placeholder)
                }
            case .success(let movieDetails):
                ScrollView(showsIndicators: false) {
                    VStack {
                        posterCard(movieDetails: movieDetails)
                        VStack(alignment: .leading){
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(movieDetails.genres){ genre in
                                        CNLabel(genre)
                                    }
                                }
                            }
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
    
    @ViewBuilder
    private func posterCard(movieDetails: MovieDetails?) -> some View {
        ZStack{
            if let imageUrl = movieDetails?.imageLoader(size: "w500"), let url = URL(string: imageUrl) {
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
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray)
                    .redacted(reason: .placeholder)
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.6)
        .cornerRadius(26)
        .overlay(alignment: .topTrailing) {
            Button(action: toggleScheme) {
                Image("ic_mode")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(Color.white)
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
        .overlay(alignment: .bottomLeading) {
            ZStack{
                if let originalLanguage = movieDetails?.original_language {
                    CNLabel(string: originalLanguage)
                } else {
                    RoundedRectangle(cornerRadius: .infinity)
                        .frame(width: 72, height: 38)
                        .redacted(reason: .placeholder)
                }
            }
            .padding()
        }
        .overlay(alignment: .bottomTrailing) {
            ZStack{
                if let movieStatus = movieDetails?.status {
                    CNLabel(string: movieStatus)
                } else {
                    RoundedRectangle(cornerRadius: .infinity)
                        .frame(width: 72, height: 38)
                        .redacted(reason: .placeholder)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MovieDetailsView(466420, selectedScheme: .constant(.dark))
}

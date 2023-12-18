//
//  TVShowsListView.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import SwiftUI

struct TVShowsListView: View {
    @StateObject private var model = Model()
    
    @State private var searchQuery: String = ""
    
    @State private var selectedGenres = [Genre]()
    
    @Binding private var selectedScheme: ColorScheme?
    
    init(selectedScheme: Binding<ColorScheme?>) {
        self._selectedScheme = selectedScheme
    }
    
    var body: some View {
        listBuilder()
            .searchable(text: $searchQuery)
            .onChange(of: searchQuery) { newQuery in
                if searchQuery.count >= 2 {
                    model.searchMovies(query: newQuery)
                } else if searchQuery == "" {
                    model.getTvShows()
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .backgroundEffect()
    }
    
    @ViewBuilder
    private func listBuilder() -> some View {
        VStack(spacing: 0){
            switch model.tvShowsListUiState {
            case .idle:
                EmptyView()
            case .empty:
                VStack{
                    switch model.genresListUiState {
                    case .idle, .empty, .loading, .failure:
                        EmptyView()
                    case .success(let genres):
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(genres) { genre in
                                    let isSelected = selectedGenres.contains(where: { $0.id == genre.id })
                                    CNLabel(genre, isSelected: isSelected) { genre in
                                        handleGenre(genre: genre, isSelected: isSelected)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                    EmptyListView()
                    Spacer()
                }
                .padding(.vertical)
            case .loading:
                VStack{
                    ForEach(0..<4){ index in
                        MediaCard<TVShow>()
                    }
                    .padding(.horizontal)
                }
            case .success(let medias):
                ScrollView(showsIndicators: false){
                    LazyVStack {
                        switch model.genresListUiState {
                        case .idle, .empty, .loading, .failure:
                            EmptyView()
                        case .success(let genres):
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(genres) { genre in
                                        let isSelected = selectedGenres.contains(where: { $0.id == genre.id })
                                        CNLabel(genre, isSelected: isSelected) { genre in
                                            handleGenre(genre: genre, isSelected: isSelected)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        ForEach(medias) { media in
                            NavigationLink {
                                MovieDetailsView(media.id, selectedScheme: $selectedScheme)
                            } label: {
                                MediaCard(media)
                                    .onAppear{
                                        if media.id == medias.last?.id {
                                            model.loadMoreMovies {
                                                if searchQuery.isEmpty {
                                                    model.getTvShows()
                                                }
                                            }
                                        }
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            case .failure(let error):
                VStack{
                    switch model.genresListUiState {
                    case .idle, .empty, .loading, .failure:
                        EmptyView()
                    case .success(let genres):
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(genres) { genre in
                                    let isSelected = selectedGenres.contains(where: { $0.id == genre.id })
                                    CNLabel(genre, isSelected: isSelected) { genre in
                                        handleGenre(genre: genre, isSelected: isSelected)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                    error.errorView()
                    Spacer()
                }
                .padding(.vertical)
            }
        }
    }
    
    func handleGenre(genre: Genre, isSelected: Bool) -> Void {
        if isSelected {
            selectedGenres.removeAll(where: { $0.id == genre.id})
        } else {
            selectedGenres.append(genre)
        }
        
        model.filterMovies(preferredGenre: selectedGenres)
    }
}

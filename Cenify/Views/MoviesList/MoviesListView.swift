//
//  MoviesListView.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI
import Combine

struct MoviesListView: View {
    
    @StateObject private var model = Model()
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedScheme: ColorScheme?
    @State private var searchQuery: String = ""
    
    @State private var selectedGenres = [Genre]()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                switch model.moviesListUiState {
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
                            MovieCard()
                        }
                        .padding(.horizontal)
                    }
                case .success(let movies):
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
                            ForEach(movies) { movie in
                                NavigationLink {
                                    MovieDetailsView(movie.id, selectedScheme: $selectedScheme)
                                } label: {
                                    MovieCard(movie)
                                        .onAppear{
                                            if movie.id == movies.last?.id {
                                                model.loadMoreMovies {
                                                    if searchQuery.isEmpty {
                                                        model.getMovies()
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
            .ignoresSafeArea(.all, edges: .bottom)
            .backgroundEffect()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    navbar()
                }
            }
        }
        .preferredColorScheme(selectedScheme)
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery) { newQuery in
            if searchQuery.count >= 2 {
                model.searchMovies(query: newQuery)
            } else if searchQuery == "" {
                model.getMovies()
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.primary.opacity(0.05))
            
            UINavigationBar.appearance().standardAppearance = appearance
            
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    @ViewBuilder
    private func navbar() -> some View {
        HStack {
            Text("Welcome to Samy’s Collection!")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Button(action: toggleScheme) {
                Image("ic_mode")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical)
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
    
    func handleGenre(genre: Genre, isSelected: Bool) -> Void {
        if isSelected {
            selectedGenres.removeAll(where: { $0.id == genre.id})
        } else {
            selectedGenres.append(genre)
        }
        
        model.filterMovies(preferredGenre: selectedGenres)
    }
}

#Preview {
    MoviesListView()
}

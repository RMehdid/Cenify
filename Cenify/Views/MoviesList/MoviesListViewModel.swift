//
//  MoviesListViewModel.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

extension MoviesListView {
    final class Model: ObservableObject {
        
        @Published private(set) var moviesListUiState: UiState<[Movie]> = .loading
        @Published private(set) var genresListUiState: UiState<[Genre]> = .loading
        
        private var isLoadingMore = false
        private var moviesList = [Movie]()
        private var page: Int = 1
        
        init() {
            self.getMovies()
            self.getGenreList()
        }
        
        
        func getMovies(preferredGenre: [Genre] = []) {
            Task {
                do {
                    if preferredGenre.isEmpty {
                        moviesList.append(contentsOf: try await MovieRepo.getMovies(page: page).results)
                    } else {
                        moviesList.append(contentsOf: try await MovieRepo.getMovies(genres: preferredGenre, page: page).results)
                    }
                    
                    DispatchQueue.main.async {
                        guard !self.moviesList.isEmpty else {
                            self.moviesListUiState = .empty
                            return
                        }
                        
                        self.moviesListUiState = .success(self.moviesList)
                    }
                } catch {
                    if isLoadingMore {
                        self.isLoadingMore = false
                    } else {
                        DispatchQueue.main.async {
                            self.moviesListUiState = .failure(error as? CNError ?? .unknown)
                        }
                    }
                }
            }
        }
        
        func filterMovies(preferredGenre: [Genre]) {
            self.moviesList = []
            getMovies(preferredGenre: preferredGenre)
        }
        
        func searchMovies(query: String) {
            self.moviesList = []
            self.moviesListUiState = .loading
            Task {
                do {
                    let searchedMovies = try await MovieRepo.searchMovies(query: query).results
                    
                    DispatchQueue.main.async {
                        guard !searchedMovies.isEmpty else {
                            self.moviesListUiState = .empty
                            return
                        }
                        
                        self.moviesListUiState = .success(searchedMovies)
                    }
                } catch {
                    if self.isLoadingMore {
                        self.isLoadingMore = false
                    } else {
                        DispatchQueue.main.async {
                            self.moviesListUiState = .failure(error as? CNError ?? .unknown)
                        }
                    }
                }
            }
        }
        
        func getGenreList() {
            Task {
                do {
                    let genresList = try await MovieRepo.getGenres().genres
                    
                    DispatchQueue.main.async {
                        guard !genresList.isEmpty else {
                            self.genresListUiState = .empty
                            return
                        }
                        
                        self.genresListUiState = .success(genresList)
                    }
                } catch {
                    if isLoadingMore {
                        self.isLoadingMore = false
                    } else {
                        DispatchQueue.main.async {
                            self.genresListUiState = .failure(error as? CNError ?? .unknown)
                        }
                    }
                }
            }
        }
        
        func loadMoreMovies(_ forward: @escaping () -> Void) {
            page += 1
            self.isLoadingMore = true
            forward()
        }
    }
}

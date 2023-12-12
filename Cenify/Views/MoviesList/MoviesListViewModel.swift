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
        
        private var isLoadingMore = false
        private var moviesList = [Movie]()
        private var page: Int = 1
        
        init() {
            self.getMovies()
        }
        
        
        func getMovies() {
            Task {
                do {
                    moviesList.append(contentsOf: try await MovieRepo.getMovies(page: page).results)
                    
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
        
        func searchMovies(query: String) {
            
            Task {
                do {
                    let searchedMovies = try await MovieRepo.searchMovies(query: query, page: self.page).results
                    
                    DispatchQueue.main.async {
                        guard !self.moviesList.isEmpty else {
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
        
        func loadMoreMovies(_ forward: @escaping () -> Void) {
            page += 1
            self.isLoadingMore = true
            forward()
        }
    }
}

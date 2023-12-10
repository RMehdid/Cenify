//
//  MoviesListViewModel.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

extension MoviesListView {
    class Model: ObservableObject {
        
        @Published private(set) var moviesListUiState: UiState<[Movie]> = .empty
        @Published private(set) var isLoadingMore = false
        
        private var moviesList = [Movie]()
        private var page: Int = 1
        private var endOfList: Bool = false
        
        init() {
            self.getMovies()
        }
        
        
        func getMovies() {
            self.moviesListUiState = .loading
            Task {
                do {
                    moviesList.append(contentsOf: try await MovieRepo.getMovies(page: page))
                    
                    DispatchQueue.main.async {
                        self.moviesListUiState = .success(self.moviesList)
                    }
                } catch {
                    if isLoadingMore {
                        self.isLoadingMore = false
                    } else {
                        
                        self.moviesListUiState = .failure(error.localizedDescription)
                    }
                }
            }
        }
        
        func loadMoreMovies() {
            if !endOfList {
                page += 1
                self.isLoadingMore = true
                getMovies()
            }
        }
    }
}

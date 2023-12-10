//
//  MoviesListViewModel.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

extension MoviesListView {
    class Model: ObservableObject {
        
        @MainActor @Published private(set) var moviesListUiState: UiState<[Movie]> = .empty
        
        @Published private(set) var moviesList = [Movie]()
        @Published private(set) var isLoadingMore = false
        
        private var page: Int = 1
        private var endOfList: Bool = false
        
        init() {
            self.getMovies()
        }
        
        
        func getMovies() {
            Task {
                await MainActor.run {
                    self.moviesListUiState = .loading
                }
                
                do {
                    moviesList.append(contentsOf: try await MovieRepo.getMovies(page: page))
                    
                    await MainActor.run {
                        self.moviesListUiState = .success(moviesList)
                    }
                } catch {
                    if isLoadingMore {
                        self.isLoadingMore = false
                    } else {
                        await MainActor.run {
                            self.moviesListUiState = .failure(error.localizedDescription)
                        }
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

//
//  TVShowsListViewModel.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import Foundation

extension TVShowsListView {
    class Model: ObservableObject {
        @Published private(set) var tvShowsListUiState: UiState<[TVShow]> = .loading
        @Published private(set) var genresListUiState: UiState<[Genre]> = .loading
        
        private var isLoadingMore = false
        private var tvShowsList = [TVShow]()
        private var page: Int = 1
        
        init() {
            self.getTvShows()
            self.getGenreList()
        }
        
        func getTvShows(preferredGenre: [Genre] = []) {
            Task {
                do {
                    
                    tvShowsList.append(contentsOf: try await TVRepo.getTvShows(genres: preferredGenre, page: page).results)
                    
                    DispatchQueue.main.async {
                        guard !self.tvShowsList.isEmpty else {
                            self.tvShowsListUiState = .empty
                            return
                        }
                        
                        self.tvShowsListUiState = .success(self.tvShowsList)
                    }
                } catch {
                    if isLoadingMore {
                        self.isLoadingMore = false
                    } else {
                        DispatchQueue.main.async {
                            self.tvShowsListUiState = .failure(error as? CNError ?? .unknown)
                        }
                    }
                }
            }
        }
        
        func filterMovies(preferredGenre: [Genre]) {
            self.tvShowsList = []
            getTvShows(preferredGenre: preferredGenre)
        }
        
        func searchMovies(query: String) {
            self.tvShowsList = []
            self.tvShowsListUiState = .loading
            Task {
                do {
                    let searchedTvShows = try await TVRepo.searchTvShows(query: query).results
                    
                    DispatchQueue.main.async {
                        guard !searchedTvShows.isEmpty else {
                            self.tvShowsListUiState = .empty
                            return
                        }
                        
                        self.tvShowsListUiState = .success(searchedTvShows)
                    }
                } catch {
                    if self.isLoadingMore {
                        self.isLoadingMore = false
                    } else {
                        DispatchQueue.main.async {
                            self.tvShowsListUiState = .failure(error as? CNError ?? .unknown)
                        }
                    }
                }
            }
        }
        
        func getGenreList() {
            Task {
                do {
                    let genresList = try await TVRepo.getGenres().genres
                    
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
        
        func loadMoreTvshows(_ forward: @escaping () -> Void) {
            page += 1
            self.isLoadingMore = true
            forward()
        }
    }
}

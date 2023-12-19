//
//  TvShowDetailViewModel.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import Foundation

extension TvShowDetailsView {
    final class Model: ObservableObject {
        @Published private(set) var tvShowDetailsUiState: UiState<TvShowDetail> = .empty
        @Published private(set) var episodesUiState: UiState<[Episode]> = .empty
        
        func getTvShowDetail(_ id: Int) {
            self.tvShowDetailsUiState = .loading
            
            Task {
                do {
                    let tvShowDetails = try await TVRepo.getTvShowDetail(id)
                    
                    DispatchQueue.main.async {
                        self.tvShowDetailsUiState = .success(tvShowDetails)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.tvShowDetailsUiState = .failure(error as? CNError ?? .unknown)
                    }
                }
            }
        }
        
        func getEpisodes(tvShowId: Int, seasonNum: Int) {
            self.episodesUiState = .loading
            
            Task {
                do {
                    let episodes = try await TVRepo.getSeasonDetails(tvShowId: tvShowId, seasonNum: seasonNum).episodes
                    
                    guard !episodes.isEmpty else {
                        DispatchQueue.main.async {
                            self.episodesUiState = .empty
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.episodesUiState = .success(episodes)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.tvShowDetailsUiState = .failure(error as? CNError ?? .unknown)
                    }
                }
            }
        }
    }
}

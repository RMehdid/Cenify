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
    }
}

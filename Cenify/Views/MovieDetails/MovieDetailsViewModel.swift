//
//  MovieDetailsViewModel.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import Foundation

extension MovieDetailsView {
    class Model: ObservableObject {
        
        @Published private(set) var movieDetailsUiState: UiState<MovieDetails> = .empty
        
        func getMovieDetail(_ id: Int) {
            self.movieDetailsUiState = .loading
            
            Task {
                do {
                    let movieDetails = try await MovieRepo.getMovieDetail(id)
                    
                    DispatchQueue.main.async {
                        self.movieDetailsUiState = .success(movieDetails)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.movieDetailsUiState = .failure(error.localizedDescription)
                    }
                }
            }
        }
    }
}

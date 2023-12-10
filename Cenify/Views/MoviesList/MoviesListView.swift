//
//  MoviesListView.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

struct MoviesListView: View {
    
    @StateObject private var model = Model()
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedScheme: ColorScheme?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                VStack{
                    navbar()
                    Rectangle()
                        .frame(height: 2)
                        .opacity(0.4)
                }
                switch model.moviesListUiState {
                case .empty:
                    EmptyView()
                case .loading:
                    Spacer()
                case .success(let movies):
                    ScrollView(showsIndicators: false){
                        LazyVStack{
                            ForEach(movies) { movie in
                                NavigationLink {
                                    MovieDetailsView(movie.id, selectedScheme: $selectedScheme)
                                } label: {
                                    MovieCard(movie)
                                        .onAppear{
                                            if movie.id == movies.last?.id {
                                                model.loadMoreMovies()
                                            }
                                        }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical)
                    }
                case .failure(let error):
                    Spacer()
                    Text(error)
                    Spacer()
                }
            }
            .padding()
            .backgroundEffect()
        }
        .preferredColorScheme(selectedScheme)
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
    }
    
    private func toggleScheme() {
        withAnimation(.smooth){
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
}

#Preview {
    MoviesListView()
}

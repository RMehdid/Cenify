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
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                switch model.moviesListUiState {
                case .idle:
                    EmptyView()
                case .empty:
                    Spacer()
                    EmptyListView()
                    Spacer()
                case .loading:
                    VStack{
                        ForEach(0..<4){ index in
                            MovieCard()
                        }
                    }
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
                                                model.loadMoreMovies {
                                                    if searchQuery.isEmpty {
                                                        model.getMovies()
                                                    } else {
                                                        model.searchMovies(query: searchQuery)
                                                    }
                                                }
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
                    error.errorView()
                    Spacer()
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .padding(.horizontal)
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
        .onSubmit(of: .search) {
            model.searchMovies(query: searchQuery)
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
}

#Preview {
    MoviesListView()
}

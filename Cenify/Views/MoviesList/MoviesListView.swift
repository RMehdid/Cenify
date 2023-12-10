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
        VStack {
            navbar()
            switch model.moviesListUiState {
            case .empty:
                EmptyView()
            case .loading:
                EmptyView()
            case .success(let movies):
                ForEach(movies) { movie in
                    MovieCard(movie)
                }
            case .failure(let string):
                EmptyView()
            }
        }
        .padding()
        .backgroundEffect()
        .preferredColorScheme(selectedScheme)
    }
    
    @ViewBuilder
    private func navbar() -> some View {
        HStack {
            Text("Welcome to Samy’s Collection!")
                .font(.primary, .semiBold, 20)
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

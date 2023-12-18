//
//  DiscoverView.swift
//  Cenify
//
//  Created by Samy Mehdid on 18/12/2023.
//

import SwiftUI

struct DiscoverView: View {
    
    @StateObject private var model = Model()
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedScheme: ColorScheme?
    
    var body: some View {
        NavigationStack {
            TabView {
                MoviesListView(selectedScheme: $selectedScheme)
                    .tabItem {
                        Label("Movies", image: "ic_movie")
                    }
                TVShowsListView(selectedScheme: $selectedScheme)
                    .tabItem {
                        Label("TV Shows", image: "ic_tv_show")
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                navbar()
            }
        }
        .preferredColorScheme(selectedScheme)
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

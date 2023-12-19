//
//  TvShowDetailsView.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import SwiftUI
import Kingfisher

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct TvShowDetailsView: View {
    private let id: Int
    
    @Binding private var selectedScheme: ColorScheme?
    
    @StateObject private var model = Model()
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var selectedSeason: Season?
    
    @State private var scrollPosition: CGFloat = 0
    
    private var isHeader: Bool {
        return scrollPosition > 120
    }
    
    init(_ id: Int, selectedScheme: Binding<ColorScheme?>) {
        self.id = id
        self._selectedScheme = selectedScheme
    }
    
    var body: some View {
        ZStack{
            switch model.tvShowDetailsUiState {
            case .empty, .idle:
                EmptyView()
            case .loading:
                VStack(spacing: 16){
                    posterCard(tvShowDetails: nil)
                    
                    VStack(alignment: .leading, spacing: 16){
                        HStack{
                            ForEach(MovieDetails.dumbForShimmer.genres){ genre in
                                CNLabel(genre)
                                    .redacted(reason: .placeholder)
                            }
                        }
                        HStack{
                            Text(MovieDetails.dumbForShimmer.title)
                                .redacted(reason: .placeholder)
                            
                            Spacer()
                            HStack{
                                Image("ic_star")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .redacted(reason: .placeholder)
                                
                                Text(MovieDetails.dumbForShimmer.vote_average.toString)
                                    .redacted(reason: .placeholder)
                            }
                        }
                        Text(MovieDetails.dumbForShimmer.release_date)
                            .redacted(reason: .placeholder)
                    }
                    
                    Text(MovieDetails.dumbForShimmer.overview)
                        .redacted(reason: .placeholder)
                }
                .padding(.horizontal)
            case .success(let tvShowDetails):
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        posterCard(tvShowDetails: tvShowDetails)
                            .padding(.horizontal)
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewOffsetKey.self,
                                        value: -$0.frame(in: .named("scroll")).origin.y)
                            })
                            .scaleEffect(scrollPosition > 120 ? 1.15 : 1)
                        VStack(alignment: .leading){
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(tvShowDetails.genres){ genre in
                                        CNLabel(genre)
                                    }
                                }
                            }
                            Menu {
                                ForEach(tvShowDetails.seasons) { season in
                                    Button(season.name) {
                                        self.selectedSeason = season
                                        model.getEpisodes(tvShowId: tvShowDetails.id, seasonNum: season.season_number)
                                    }
                                }
                            } label: {
                                Label(selectedSeason?.name ?? "Seasons", systemImage: "chevron.down")
                            }
                            HStack{
                                Text(selectedSeason?.name ?? tvShowDetails.title)
                                    .font(.system(size: 32, weight: .bold))
                                Spacer()
                                HStack{
                                    Image("ic_star")
                                        .resizable()
                                        .renderingMode(.template)
                                        .frame(width: 24, height: 24)
                                    
                                    Text(selectedSeason?.vote_average.toString ?? tvShowDetails.vote_average.toString)
                                        .font(.system(size: 16, weight: .semibold))
                                }
                            }
                            Text(selectedSeason?.air_date ?? tvShowDetails.release_date)
                                .font(.system(size: 16, weight: .regular))
                        }
                        .padding(.horizontal)
                        
                        Text(selectedSeason?.overview ?? tvShowDetails.overview)
                            .font(.system(size: 14, weight: .regular))
                            .padding(.horizontal)
                        
                        switch model.episodesUiState {
                        case .idle, .empty, .failure:
                            EmptyView()
                        case .loading:
                            ForEach(0..<4, id: \.hashValue) {_ in
                                EpisodeCard()
                            }
                        case .success(let episodes):
                            ForEach(episodes) { episode in
                                EpisodeCard(episode: episode)
                            }
                        }
                    }
                    .onPreferenceChange(ViewOffsetKey.self) { newValue in
                        withAnimation { self.scrollPosition = newValue }
                    }
                }
                .coordinateSpace(name: "scroll")
                
            case .failure(let error):
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        error.errorView()
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            model.getTvShowDetail(id)
        }
        .navigationBarHidden(true)
        .backgroundEffect()
        .backOnSwipe(presentationMode: presentationMode)
    }
    
    @ViewBuilder
    private func posterCard(tvShowDetails: TvShowDetail?) -> some View {
        ZStack{
            if let imageUrl = selectedSeason?.imageLoader(size: "w500") ?? tvShowDetails?.imageLoader(size: "w500"), let url = URL(string: imageUrl) {
                KFImage(url)
                    .resizable()
                    .placeholder { progress in
                        Color.gray
                    }
                    .overlay{
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)), location: 0),
                                .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)), location: 0.5),
                                .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)), location: 1)]),
                            startPoint: .top,
                            endPoint: .bottom)
                    }
            } else {
                RoundedRectangle(cornerRadius: isHeader ? 0 : 26)
                    .fill(Color.gray)
                    .redacted(reason: .placeholder)
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.6)
        .cornerRadius(isHeader ? 0 : 26)
        .overlay(alignment: .topTrailing) {
            Button(action: toggleScheme) {
                Image("ic_mode")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .foregroundStyle(Color.white)
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
        }
        .overlay(alignment: .bottomLeading) {
            ZStack{
                if let originalLanguage = tvShowDetails?.original_language {
                    CNLabel(string: originalLanguage)
                } else {
                    RoundedRectangle(cornerRadius: .infinity)
                        .frame(width: 72, height: 38)
                        .redacted(reason: .placeholder)
                }
            }
            .padding()
            .opacity(isHeader ? 0 : 1)
        }
        .overlay(alignment: .bottomTrailing) {
            ZStack{
                if let seasonsCount = tvShowDetails?.number_of_seasons {
                    CNLabel(string: seasonsCount.formatted() + " seasons")
                } else {
                    RoundedRectangle(cornerRadius: .infinity)
                        .frame(width: 72, height: 38)
                        .redacted(reason: .placeholder)
                }
            }
            .padding()
            .opacity(isHeader ? 0 : 1)
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
    TvShowDetailsView(1622, selectedScheme: .constant(.dark))
}

//
//  PosterCard.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI
import Kingfisher

struct PosterCard: View {
    
    private var imageUrl: String?
    private var movieStatus: String?
    private var originalLanguage: String?
    
    private var toggleScheme: (() -> Void)?
    
    init(imageUrl: String, movieStatus: String, originalLanguage: String, toggleScheme: @escaping () -> Void) {
        self.imageUrl = imageUrl
        self.movieStatus = movieStatus
        self.originalLanguage = originalLanguage
        self.toggleScheme = toggleScheme
    }
    
    init() {}
    
    var body: some View {
        ZStack{
            if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
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
                Rectangle()
                    .redacted(reason: .placeholder)
                    .shimmering()
            }
            VStack{
                if let toggleScheme = toggleScheme {
                    HStack{
                        Spacer()
                        Button(action: toggleScheme) {
                            Image("ic_mode")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.white)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                Spacer()
                HStack{
                    if let originalLanguage = originalLanguage {
                        label(originalLanguage)
                    } else {
                        RoundedRectangle(cornerRadius: .infinity)
                            .frame(width: 72, height: 38)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    Spacer()
                    if let movieStatus = movieStatus {
                        label(movieStatus)
                    } else {
                        RoundedRectangle(cornerRadius: .infinity)
                            .frame(width: 72, height: 38)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                }
            }
            .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.6)
        .cornerRadius(26)
    }
    
    @ViewBuilder
    private func label(_ string: String) -> some View {
        ZStack{
            Text(string)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.white)
                .padding(.vertical)
                .padding(.horizontal, 28)
                .background {
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.10000000149011612)), location: 0),
                        .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4000000059604645)), location: 1)]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading))
                    
                    RoundedRectangle(cornerRadius: .infinity)
                        .strokeBorder(LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), location: 0),
                                .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), location: 1)]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading),
                                      lineWidth: 1
                        )
                }
        }
    }
}

#Preview {
    PosterCard()
}

//
//  PosterCard.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI
import Kingfisher

struct PosterCard: View {
    
    let imageUrl: String
    let movieStatus: String
    let originalLanguage: String
    
    var body: some View {
        ZStack{
            if let url = URL(string: imageUrl) {
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
            }
            VStack{
                HStack{
                    Spacer()
                    Image("ic_mode")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
                HStack{
                    label(originalLanguage)
                    Spacer()
                    label(movieStatus)
                }
            }
            .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.6)
        .cornerRadius(26)
        .padding(.horizontal)
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
    PosterCard(imageUrl: "https://image.tmdb.org/t/p/w500/sEaLO9s7CIN3fjz8R3Qksum44en.jpg", movieStatus: "Released", originalLanguage: "EN")
}

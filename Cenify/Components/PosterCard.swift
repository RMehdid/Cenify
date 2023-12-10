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
                .font(.primary, .medium, 12)
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
    PosterCard(imageUrl: "/dB6Krk806zeqd0YNp2ngQ9zXteH.jpg", movieStatus: "Released", originalLanguage: "EN")
}

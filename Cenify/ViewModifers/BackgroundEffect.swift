//
//  BackgroundEffect.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

struct BackgroundEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                Color("CNBack")
                    .ignoresSafeArea()
                //Ellipse 3
                Ellipse()
                    .fill(Color("CNThird"))
                    .frame(width: 491, height: 464)
                    .position(x: 200, y: 350)
                    .ignoresSafeArea()
                
                //Ellipse 2
                Circle()
                    .fill(Color("CNSecond"))
                    .frame(width: 438, height: 438)
                    .position(x: 200, y: 200)
                    .ignoresSafeArea()
                
                //Ellipse 1
                Ellipse()
                    .fill(Color("CNFirst"))
                    .frame(width: 438, height: 444)
                    .position(x: 200, y: 0)
                    .ignoresSafeArea()
                
                // Layer
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 0.1921568661928177, green: 0.1882352977991104, blue: 0.3019607961177826, alpha: 0)), location: 0),
                            .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)), location: 1)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    MoviesListView(selectedScheme: .constant(.dark))
}

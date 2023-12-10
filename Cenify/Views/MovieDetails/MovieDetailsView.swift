//
//  MovieDetailsView.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject private var model = Model()
    
    var body: some View {
        VStack{
            PosterCard(imageUrl: <#T##String#>, movieStatus: <#T##String#>, originalLanguage: <#T##String#>)
        }
    }
}

#Preview {
    MovieDetailsView()
}

//
//  NoInternetView.swift
//  Cenify
//
//  Created by Samy Mehdid on 11/12/2023.
//

import SwiftUI

struct FailView: View {
    
    var iconName: String
    var message: String
    
    var body: some View {
        VStack{
            Image(iconName)
                .resizable()
                .renderingMode(.template)
                .frame(width: 84, height: 84)
            
            Text(message)
                .font(.system(size: 20, weight: .bold))
        }
    }
}

struct NetworkError: View {
    var body: some View {
        FailView(iconName: "ic_no_internet", message: "No internet connection")
    }
}

struct DecodingError: View {
    var body: some View {
        FailView(iconName: "ic_warning", message: "Decoding error")
    }
}

struct ForbiddenError: View {
    var body: some View {
        FailView(iconName: "ic_profile_error", message: "Uou don’t have the right to be here")
    }
}

struct BadUrl: View {
    var body: some View {
        FailView(iconName: "ic_code_error", message: "Bad url")
    }
}

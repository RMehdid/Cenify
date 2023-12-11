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

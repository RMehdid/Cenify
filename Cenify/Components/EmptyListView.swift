//
//  EmptyView.swift
//  Cenify
//
//  Created by Samy Mehdid on 11/12/2023.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack{
            Image("ic_empty")
                .resizable()
                .renderingMode(.template)
                .frame(width: 84, height: 84)
            
            Text("We currently don’t have any movies")
                .font(.system(size: 20, weight: .bold))
        }
    }
}

#Preview {
    EmptyListView()
}

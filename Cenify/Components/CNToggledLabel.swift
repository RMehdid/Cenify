//
//  CNToggledLabel.swift
//  Cenify
//
//  Created by Samy Mehdid on 12/12/2023.
//

import SwiftUI

struct CNToggledLabel: View {
    
    @State private var isToggeled: Bool = false
    
    private var string: String
    
    private var toggeled: () -> Void
    
    init(_ string: String, toggeled: @escaping () -> Void) {
        self.string = string
        self.toggeled = toggeled
    }
    
    var body: some View {
        Button{
            toggeled()
            isToggeled.toggle()
            debugPrint(isToggeled)
        } label: {
            ZStack{
                Text(string)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(isToggeled ? Color("CNGlacial") : Color.primary)
                    .padding(.vertical)
                    .frame(minWidth: 68)
                    .padding(.horizontal, 4)
                    .background(.ultraThinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: .infinity)
                            .strokeBorder(
                                .primary,
                                lineWidth: 2
                            )
                    }
                    .cornerRadius(.infinity)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

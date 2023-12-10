//
//  View.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

extension View {
    func backgroundEffect() -> some View {
        modifier(BackgroundEffect())
    }
    
    func backOnSwipe(presentationMode: Binding<PresentationMode>) -> some View {
        self.modifier(BackHandler(presentationMode: presentationMode))
    }
}

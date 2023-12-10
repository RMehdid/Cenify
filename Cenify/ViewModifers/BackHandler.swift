//
//  BackHandler.swift
//  Cenify
//
//  Created by Samy Mehdid on 10/12/2023.
//

import SwiftUI

struct BackHandler: ViewModifier {
    @GestureState private var dragOffset = CGSize.zero
    @Binding var presentationMode: PresentationMode
    
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 20 &&
                   value.translation.width > 100) {
                    self.presentationMode.dismiss()
                }
            }))
    }
}

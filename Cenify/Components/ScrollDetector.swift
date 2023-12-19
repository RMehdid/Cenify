//
//  ScrollDetector.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import SwiftUI

struct ScrollDetector: UIViewRepresentable {
    var onScroll: (CGFloat) -> ()
    
    var onDraggingEnd: (CGFloat, CGFloat) -> ()
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollview = uiView.superview?.superview?.superview as? UIScrollView {
                print(scrollview)
            }
        }
    }
}

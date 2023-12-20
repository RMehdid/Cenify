//
//  RetryButton.swift
//  Cenify
//
//  Created by Samy Mehdid on 20/12/2023.
//

import SwiftUI

extension RetryButton {
    final class RefreshActionPerformer: ObservableObject {
        @Published private(set) var isPerforming = false
        
        func perform(_ action: RefreshAction) async {
            guard !isPerforming else { return }
            isPerforming = true
            await action()
            isPerforming = false
        }
    }
}

struct RetryButton: View {
    var title: LocalizedStringKey = "Retry"
    
    @Environment(\.refresh) private var action
    @StateObject private var actionPerformer = RefreshActionPerformer()

    var body: some View {
        if let action = action {
            Button {
                Task {
                    await actionPerformer.perform(action)
                }
            } label: {
                ZStack {
                    if actionPerformer.isPerforming {
                        Text(title).hidden()
                        ProgressView()
                    } else {
                        Text(title)
                    }
                }
            }
            .disabled(actionPerformer.isPerforming)
        }
    }
}

#Preview {
    RetryButton()
}

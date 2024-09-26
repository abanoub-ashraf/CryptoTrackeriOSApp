//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 13/04/2024.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25), 
                radius: 10,
                x: 0,
                y: 0
            )
            .padding()
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout, body: {
    CircleButtonView(iconName: "info")
})

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout, body: {
    CircleButtonView(iconName: "plus")
        .preferredColorScheme(.dark)
})

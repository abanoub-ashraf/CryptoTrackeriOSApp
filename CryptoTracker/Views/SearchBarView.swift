//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 19/04/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var closeImage: some View {
        Image(systemName: "xmark.circle.fill")
            .padding()
            .offset(x: 10)
            .foregroundColor(Color.theme.accent)
            .opacity(searchText.isEmpty ? 0.0 : 1)
            .onTapGesture {
                UIApplication.shared.endEditing()
                searchText = ""
            }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(closeImage, alignment: .trailing)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}

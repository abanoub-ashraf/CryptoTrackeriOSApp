//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 19/04/2024.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(coin: Preview.dev.coin)
        .padding()
}

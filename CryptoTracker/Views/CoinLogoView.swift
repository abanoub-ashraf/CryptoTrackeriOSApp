//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 20/04/2024.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: Preview.dev.coin)
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: Preview.dev.coin)
        .preferredColorScheme(.dark)
}

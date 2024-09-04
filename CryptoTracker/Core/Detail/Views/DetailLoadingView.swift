//
//  DetailLoadingView.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 13/07/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    DetailLoadingView(coin: .constant(Preview.dev.coin))
}

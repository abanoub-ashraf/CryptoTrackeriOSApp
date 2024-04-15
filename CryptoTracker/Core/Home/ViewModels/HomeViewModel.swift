//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 15/04/2024.
//

import Foundation

///
/// ObservableObject means it can be observed from the View
///
class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var  portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}

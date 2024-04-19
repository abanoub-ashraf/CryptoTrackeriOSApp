//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 17/04/2024.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        var baseUrl = "https://api.coingecko.com/api/v3/coins/markets?"
        baseUrl += "vs_currency=usd&"
        baseUrl += "order=market_cap_desc&"
        baseUrl += "per_page=250&"
        baseUrl += "page=1&"
        baseUrl += "sparkline=true&"
        baseUrl += "price_change_percentage=24h&"
        baseUrl += "x_cg_demo_api_key=\(PrivateConstants.shared.apiKey)"
        
        guard let url = URL(string: baseUrl) else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}

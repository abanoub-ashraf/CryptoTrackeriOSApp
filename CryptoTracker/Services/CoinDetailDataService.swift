//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 12/07/2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    
    private var coinDetailsSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        var baseUrl = "https://api.coingecko.com/api/v3/coins/\(coin.id)?"
        baseUrl += "localization=false&"
        baseUrl += "tickers=false&"
        baseUrl += "market_data=false&"
        baseUrl += "community_data=false&"
        baseUrl += "developer_data=false&"
        baseUrl += "sparkline=false"
        baseUrl += "x_cg_demo_api_key=\(PrivateConstants.shared.apiKey)"
        
        guard let url = URL(string: baseUrl) else { return }
        
        coinDetailsSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailsSubscription?.cancel()
            })
    }
}

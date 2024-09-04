//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 20/04/2024.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        var baseUrl = "https://api.coingecko.com/api/v3/global?"
        baseUrl += "x_cg_demo_api_key=\(PrivateConstants.shared.apiKey)"
        
        guard let url = URL(string: baseUrl) else { return }
        
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}

//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 17/04/2024.
//

import Foundation
import Combine

let apiKey = "CG-hjN1DpmtceZtaJraEf7gBPiY"

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
        baseUrl += "x_cg_demo_api_key=\(apiKey)"
        
        guard let url = URL(string: baseUrl) else { return }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}

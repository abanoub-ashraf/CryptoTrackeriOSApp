//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 15/04/2024.
//

import Foundation
import Combine

///
/// ObservableObject means it can be observed from the View
///
class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title1", value: "Value1", percentageChange: 1),
        StatisticModel(title: "Title2", value: "Value2"),
        StatisticModel(title: "Title3", value: "Value3"),
        StatisticModel(title: "Title4", value: "Value4", percentageChange: -7),
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var  portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            	coin.symbol.lowercased().contains(lowercasedText) ||
            	coin.id.lowercased().contains(lowercasedText)
        }
    }
}

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
    @Published var allCoins: [CoinModel] = []
    @Published var  portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}

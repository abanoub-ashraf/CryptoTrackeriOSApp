//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Abanoub Ashraf on 23/06/2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        self.container = NSPersistentContainer(name: containerName)
        self.container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            
            self.getPortfolio()
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            self.savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities! \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        self.applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data! \(error)")
        }
    }
    
    private func applyChanges() {
        self.save()
        self.getPortfolio()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        self.applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        self.container.viewContext.delete(entity)
        self.applyChanges()
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
}

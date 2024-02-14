//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Алексей Моторин on 14.02.2024.
//

import Foundation
import CoreData

final class PortfolioDataService {

    @Published var savedEntities: [PortfolioEntity] = []

    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("Error loading Core Data", error)
            }
            self?.getPortfolio()
        }
    }

    // MARK: Public
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // check if coin already in portfolio
        if let entity = savedEntities.first(where: { $0.coinId == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
}

// MARK: Private
private extension PortfolioDataService {
    func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entities", error)
        }
    }

    func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }

    func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }

    func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    func applyChanges() {
        save()
        getPortfolio()
    }

    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error save to Core Data", error)
        }
    }
}

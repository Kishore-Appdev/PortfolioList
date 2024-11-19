//
//  CoreDataManager.swift
//  Portfolio
//
//  Created by Kishore B on 17/11/24.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Portfolio")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func saveHoldingsDataInCoreData(userHoldings: [UserHolding]) {
        let context = CoreDataManager.shared.context
        
        for holding in userHoldings {
            let entity = Holdings(context: context)
            entity.symbol = holding.symbol
            entity.quantity = Int64(holding.quantity)
            entity.ltp = holding.ltp
            entity.avgPrice = holding.avgPrice
            entity.close = holding.close
            let currentValue = holding.ltp * Double(holding.quantity)
            let totalInvestment = holding.avgPrice * Double(holding.quantity)
            entity.currentValue = currentValue
            entity.totalInvestment = totalInvestment
            entity.totalPNL = currentValue - totalInvestment
            entity.todaysPNL = (holding.close - holding.ltp) * Double(holding.quantity)
        }
        
        CoreDataManager.shared.saveContext()
    }
    
    public func deleteByEntityName(entityName:String) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            _ = try self.context.execute(request)
        } catch let error {
            print("Error in \(entityName) deletion: \(error.localizedDescription)")
        }
        CoreDataManager.shared.saveContext()
    }
    
    func fetchHoldingsData() ->[Holdings] {
        let fetchRequest: NSFetchRequest<Holdings> = Holdings.fetchRequest()
        
        do {
            let fetchedUserHoldings = try context.fetch(fetchRequest)
            return fetchedUserHoldings
        } catch {
//            print("Error fetching data from Core Data: \(error.localizedDescription)")
            return []
        }
    }
    
}

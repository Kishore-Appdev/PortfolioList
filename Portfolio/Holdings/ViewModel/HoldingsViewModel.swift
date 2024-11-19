//
//  ViewModel.swift
//  Portfolio
//
//  Created by Kishore B on 17/11/24.
//

import Foundation
import UIKit
class HoldingsViewModel:NSObject{
    var holdingsData:[Holdings] = []
    var refreshData:(()->Void)?
    var currentValue:Double = 0
    var totalInvestment:Double = 0
    var totalPNL:Double = 0
    var todaysPNL:Double = 0
    
    
    override init() {
        super.init()
        DispatchQueue.main.async {
            self.holdingsData = CoreDataManager.shared.fetchHoldingsData()
            self.calculateAllTotalValues()
               if let action = self.refreshData{
                   action()
               }
        }
      
        Task{
            let result = await ApiServiceHelper.shared.fetchHoldingsDataFromAPI()
            DispatchQueue.main.async {
                switch result {
                case .success(let userHoldings):
//                    print("Data fetched: \(userHoldings)")
                    CoreDataManager.shared.deleteByEntityName(entityName: "Holdings")
                    CoreDataManager.shared.saveHoldingsDataInCoreData(userHoldings: userHoldings)
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
             self.holdingsData = CoreDataManager.shared.fetchHoldingsData()
             self.calculateAllTotalValues()
                if let action = self.refreshData{
                    action()
                }

            }
        }
    }
    
    func calculateAllTotalValues(){
        self.currentValue = 0
        self.totalInvestment = 0
        self.totalPNL = 0
        self.todaysPNL = 0
        
        for holding in  self.holdingsData{
            self.currentValue += holding.currentValue
            self.totalInvestment += holding.totalInvestment
            self.totalPNL += holding.totalPNL
            self.todaysPNL += holding.todaysPNL
        }
    }
    
    
}

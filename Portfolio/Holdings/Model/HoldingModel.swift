//
//  HoldingModel.swift
//  Portfolio
//
//  Created by Kishore B on 17/11/24.
//

import Foundation
struct HoldingApiModel:Decodable{
    let data: DataContainer
}

struct DataContainer: Decodable {
    let userHolding: [UserHolding]
}

struct UserHolding: Decodable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
}

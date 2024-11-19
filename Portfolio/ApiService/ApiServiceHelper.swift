//
//  ApiServiceHelper.swift
//  Portfolio
//
//  Created by Kishore B on 17/11/24.
//

import Foundation
class ApiServiceHelper:NSObject{
    public static let shared = ApiServiceHelper()
    
    
    func fetchHoldingsDataFromAPI() async -> Result<[UserHolding], Error>{
        guard let url = URL(string: "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/") else {
            print("Invalid URL")
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(HoldingApiModel.self, from: data)
            return .success(apiResponse.data.userHolding)

        } catch {
            print("Error: \(error.localizedDescription)")
            return .failure(error)

        }
    }

}

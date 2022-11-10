//
//  CoinModel.swift
//  Runner
//
//  Created by phuocanh on 08/11/2022.
//

import Foundation
class CoinData {
    var name: String
    var symbol: String
    var price: Double
 

    init?(JSONData data: [String: String]) {
        self.name = data["name"]!
        self.symbol = data["symbol"]!
        self.price = Double(data["price"]!)!
    }
}

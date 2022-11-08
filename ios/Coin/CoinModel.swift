//
//  CoinModel.swift
//  Runner
//
//  Created by phuocanh on 08/11/2022.
//

import Foundation
class CoinData {
    var name: String
    var description: String
    var quantity: Int
    var price: Double
    var deliverName: String
    var deliverStartDate: Date
    var deliverEndDate: Date
    var deliverDate: ClosedRange<Date>

    init?(JSONData data: [String: String]) {
        self.name = data["name"]!
        self.description = data["description"]!
        self.quantity = Int(data["quantity"]!)!
        self.price = Double(data["price"]!)!
        self.deliverName = data["deliverName"]!
        self.deliverStartDate = Date(timeIntervalSince1970: Double(data["deliverStartDate"]!)! / 1000)
        self.deliverEndDate = Date(timeIntervalSince1970: Double(data["deliverEndDate"]!)! / 1000)

        deliverDate = self.deliverStartDate...self.deliverEndDate
    }
}

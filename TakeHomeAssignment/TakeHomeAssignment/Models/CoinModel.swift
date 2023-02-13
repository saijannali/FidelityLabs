//
//  CoinModel.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/11/23.
//

import Foundation

struct Coin: Identifiable{
    let id = UUID().uuidString
    let name: String
    let USD: Double
}

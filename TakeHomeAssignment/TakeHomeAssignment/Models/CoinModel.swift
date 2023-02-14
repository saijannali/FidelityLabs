//
//  CoinModel.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/11/23.
//

import Foundation

/*
 {
   "BTC": {
     "USD": 21699.93
   },
   "ETH": {
     "USD": 1523.04
   },
   "XRP": {
     "USD": 0.3822
   }
 ...
 */


struct Coin: Decodable, Identifiable, Hashable{
    let id = UUID().uuidString
    let usd: Double
    let coinName: String

    // Define coding key for decoding use
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        usd = try container.decode(Double.self, forKey: CodingKeys.usd)
        
        // get key string from path
        coinName = container.codingPath.first!.stringValue
    }
}

struct Coins: Decodable {

    var array: [Coin]
  
    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        // not used but needed to compile
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        // container for first lvl keys
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [Coin]()

        for key in container.allKeys {
            let decodedObject = try container.decode(Coin.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        array = tempArray
    }
}

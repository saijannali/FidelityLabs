//
//  ScreenTwoViewModel.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/11/23.
//

import Foundation
import Combine
import RealmSwift

class CoinListViewModel: ObservableObject {
    
    @Published var coinsList: [Coin] = []
    
    private let cryptoCompareDataService = CryptoCompareDataService()
    private var cancellables = Set<AnyCancellable>()

    
    init() {
        addSubscribers()
    }
    
    func referesh() {
        cryptoCompareDataService.getData()
        print("refreshed")
    }
    
    private func addSubscribers() {
        cryptoCompareDataService.$coinsList
            .map(sortCoins)
            .sink { [weak self] (returnedCoinsList) in
                self?.coinsList = returnedCoinsList
            }
            .store(in: &cancellables)
    }
    
    private func sortCoins(unsortedCoins: [Coin]) -> [Coin] {
        return unsortedCoins.sorted(by: {$0.coinName < $1.coinName})
    }
    
}



//
//  ScreenTwoViewModel.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/11/23.
//

import Foundation
import Combine

class ScreenTwoViewModel: ObservableObject {
    
    @Published var coinsList: [Coin] = []
    
    private let cryptoCompareDataService = CryptoCompareDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        cryptoCompareDataService.$coinsList
            .sink { [weak self] (returnedList) in
                self?.coinsList = returnedList
            }
            .store(in: &cancellables)
    }
    
}

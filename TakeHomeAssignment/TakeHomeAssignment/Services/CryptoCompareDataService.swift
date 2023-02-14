//
//  CryptoCompareDataService.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/11/23.
//

import Foundation
import Combine

class CryptoCompareDataService {
    @Published var coinsList: [Coin] = []
    private var coinSubscription: AnyCancellable?
    private var timer: AnyCancellable?
    let queries: String = "BTC,ETH,XRP,USDT,BNB,DOGE,SHIB"
    
    init() {
        getData()
        startTimer()
    }

    func getData() {
        guard let apiURL: URL = URL(string: "https://min-api.cryptocompare.com/data/pricemulti?fsyms=\(queries)&tsyms=USD&&api_key=46f0cc20e15061892833066651695802c73a2b2346c468f547431caceb40bbe2") else{
            print(NetworkManager.NetworkingError.invalidURL)
            return
        }
        
        coinSubscription = NetworkManager.download(url: apiURL)
            .decode(type: Coins.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.coinsList = returnedCoins.array
            })
    }
    
    func startTimer() {

        timer = Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                print("get data called")
                self?.getData()
            }
    }
    
}

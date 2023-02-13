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
    private var cancellables = Set<AnyCancellable>()
    let queries: String = "BTC,ETH,XRP,USDT,BNB"

    init() {
        getData()
    }
    
    func getData() {
        let apiURL: URL = URL(string: "https://min-api.cryptocompare.com/data/pricemulti?fsyms=\(queries)&tsyms=USD,EUR&&api_key=46f0cc20e15061892833066651695802c73a2b2346c468f547431caceb40bbe2")!
        
        let _ =
        URLSession.shared.dataTaskPublisher(for: apiURL)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (output, response) in
                guard let res = response as? HTTPURLResponse, res.statusCode >= 200 && res.statusCode < 300  else {
                    throw NetworkManager.NetworkingError.badURLResponse(url: apiURL)
                }
                return output
            }
            .decode(type: [String: [String: Double]].self, decoder: JSONDecoder())
            .map({ (dict) -> [Coin] in
                var res: [Coin] = []
                dict.forEach { (key: String, value: [String : Double]) in
                    res.append(Coin(name: key, USD: value["USD"] ?? -1.0))
                }
                return res
            })
            .sink { (completion) in
                switch completion{
                case .finished:
                    print("finished")
                case .failure(let err):
                    print("completion err: \(err)")
                }
            } receiveValue: { [weak self] (returnedList) in
                self?.coinsList = returnedList
            }
            .store(in: &cancellables)
    }
}

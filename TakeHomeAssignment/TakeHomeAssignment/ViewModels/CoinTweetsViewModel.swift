//
//  CoinTweetsViewModel.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/14/23.
//

import Foundation
import Combine

class CoinTweetsViewModel: ObservableObject{
    
    @Published var currCoinTweets: [Tweet] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let twitterDetailService : TwitterDataService
    
    init(coin: Coin) {
        self.twitterDetailService = TwitterDataService(coin: coin)
        addSubscribers()
    }
    
    func addSubscribers() {
        print("adding subs tweetmodel")
        
        twitterDetailService.$tweets
            .sink { [weak self] publishedTweets in
                self?.currCoinTweets = publishedTweets?.data ?? []
            }
            .store(in: &cancellables)
    
    }
}

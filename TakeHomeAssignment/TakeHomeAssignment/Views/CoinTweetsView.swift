//
//  CoinTweetsView.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/13/23.
//

import SwiftUI

struct coinTweetsLoadingView: View {
    let coin: Coin
    var body: some View{
        ZStack{
            if let coin = coin{
                CoinTweetsView(coin: coin)
            } else{
                Text("preventing init")
            }
        }
    }
}

struct CoinTweetsView: View {
    
    @StateObject private var coinTweetsVM: CoinTweetsViewModel
    
    let coin: Coin
    
    init(coin: Coin) {
        _coinTweetsVM = StateObject(wrappedValue: CoinTweetsViewModel(coin: coin))
        self.coin = coin
        print("\(coin.coinName) : INIT")
    }
    
    var body: some View {
        List{
            ForEach(coinTweetsVM.currCoinTweets) { tweet in
                Text(tweet.text)
            }
        }
        .navigationTitle("\(coin.coinName) Tweets")
    }
}


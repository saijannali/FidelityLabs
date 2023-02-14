//
//  CoinListView.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/10/23.
//

import SwiftUI
import RealmSwift


//screen two loading struct?

struct CoinListView: View {
    //@Binding var selectedCoin: Coin?
    //@Binding var showCoinTweetView: Bool
    @StateObject var vm = CoinListViewModel()
    @ObservedResults(RealmCoin.self) var realmCoins

    
    var body: some View {
        if vm.coinsList.isEmpty{
            ProgressView()
        } else{
            List {
                ForEach(vm.coinsList, id: \.coinName) { coin in
                        HStack{
                            HStack{
                                Text("\(coin.coinName)")
                                Spacer()
                                Text("\(coin.usd.asCurrencyWith2Decimals())")
                            }
                            .background(Color.green.opacity(0.001))
                            .onTapGesture {
                                segue(coin: coin)
                            }
                            Spacer()
                            Image(systemName: isFav(coin: coin) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    saveAsFav(coin: coin)
                                }
                            NavigationLink(value: coin) {
                                Text("Tweets")
                                    .frame(width: 100)
                                    .background(Color.gray.opacity(0.25))
                            }
                        }
                }
                
                .refreshable {
                    vm.referesh()
                }
                .navigationTitle("Coins")
            }
        }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CoinListView()
        }
    }
}

    

//MARK: - Realm funcs
extension CoinListView {
    
    private func isFav(coin: Coin) -> Bool {
        let realmCoin = realmCoins.first(where: {$0.name == coin.coinName})
        return realmCoin?.isFavorite ?? false
    }
    
    private func saveAsFav(coin: Coin) {
        if let coinExists = realmCoins.first(where: {$0.name == coin.coinName}) {
            do {
                let realm = realmCoins.realm!.thaw()
                try realm.write {
                    coinExists.thaw()?.isFavorite.toggle()
                }
            } catch let err {
                print("error setting/unsetting as favorite: \(err)")
            }
        } else{
            let newCoin = RealmCoin()
            newCoin.name = coin.coinName
            newCoin.isFavorite = true
            $realmCoins.append(newCoin)
        }
    }
    
    private func segue(coin: Coin) {
        print("tapped: \(coin.coinName)")
        //selectedCoin = coin
        //showCoinTweetView = true
    }
}


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
    @StateObject var vm = CoinListViewModel()
    //@ObservedRealmObject var realmCoinGroup: RealmCoinGroup
    @ObservedResults(RealmCoin.self) var realmCoins
    
    var body: some View {
        if vm.coinsList.isEmpty{
            ProgressView()
        } else{
            List {
                ForEach(vm.coinsList) { coin in
                    HStack {
                        Text("\(coin.coinName)")
                        Spacer()
                        Text("\(coin.usd.asCurrencyWith2Decimals())")
                        Spacer()
                        Image(systemName: isFav(coin: coin) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                saveAsFav(coin: coin)
                            }
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

struct ScreenTwo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            //ScreenTwo(vm: ScreenTwoViewModel(), realmCoins: RealmCoin())
        }
    }
}

//MARK: - Realm funs
extension CoinListView {
     func isFav(coin: Coin) -> Bool {
        let realmCoin = realmCoins.first(where: {$0.name == coin.coinName})
        return realmCoin?.isFavorite ?? false
     }

     func saveAsFav(coin: Coin) {
        if let coinExists = realmCoins.first(where: {$0.name == coin.coinName}) {
            let realm = realmCoins.realm!.thaw()
            try! realm.write {
                coinExists.thaw()?.isFavorite.toggle()
            }
        } else{
            let newCoin = RealmCoin()
            newCoin.name = coin.coinName
            newCoin.isFavorite = true
            $realmCoins.append(newCoin)
        }
    }
}

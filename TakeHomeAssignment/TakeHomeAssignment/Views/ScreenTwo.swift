//
//  ScreenTwo.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/10/23.
//

import SwiftUI
import RealmSwift

//screen two loading struct?

struct ScreenTwo: View {

    @ObservedObject var vm: ScreenTwoViewModel
    //@ObservedRealmObject var realmCoinGroup: RealmCoinGroup
    @ObservedResults(RealmCoin.self) var realmCoins
    
    var body: some View {
        List{
            ForEach(vm.coinsList) { coin in
                HStack {
                    Text(coin.name)
                    Spacer()
                    Text("\(coin.USD.asCurrencyWith2Decimals())")
                    Spacer()
                    Image(systemName: isFav(coin: coin) ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            saveAsFav(coin: coin)
                        }
                }
            }
        }
        .navigationTitle("Screen Two")
    }
}

struct ScreenTwo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            //ScreenTwo(vm: ScreenTwoViewModel(), realmCoins: RealmCoin())
        }
    }
}

extension ScreenTwo {
    
    private func isFav(coin: Coin) -> Bool {
        let realmCoin = realmCoins.first(where: {$0.name == coin.name})
        return realmCoin?.isFavorite ?? false
    }
    
    private func saveAsFav(coin: Coin) {
        if let coinExists = realmCoins.first(where: {$0.name == coin.name}) {
            let realm = realmCoins.realm!.thaw()
            try! realm.write {
                coinExists.thaw()?.isFavorite.toggle()
            }
        } else{
            let newCoin = RealmCoin()
            newCoin.name = coin.name
            newCoin.isFavorite = true
            $realmCoins.append(newCoin)
        }
    }
}


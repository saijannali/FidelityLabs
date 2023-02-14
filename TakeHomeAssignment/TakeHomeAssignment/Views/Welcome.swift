//
//  Welcome.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/10/23.
//

import SwiftUI
import RealmSwift

struct Welcome: View {
  
    @State private var selectedCoin: Coin? = nil
    @State private var showCoinTweetView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                ZStack {
                    Color.blue.opacity(0.6)
                        .frame(height: UIScreen.main.bounds.height/3)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Image("crypto")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fit)
                }
                
                NavigationLink(value: "") {
                    Text("Fetch All Coins")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(20)
                }
        
                Spacer()
            }
            .navigationDestination(for: String.self) { _ in
                CoinListView()
            }
            .navigationDestination(for: Coin.self, destination: { coin in
                CoinTweetsView(coin: coin)
                //coinTweetsLoadingView(coin: coin)
            })

            .navigationTitle("Welcome")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink(destination:  CoinListView()) {
                        Text("Fetch")
                    }
                })
            }
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Welcome()
        }
    }
}

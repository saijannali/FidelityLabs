//
//  Welcome.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/10/23.
//

import SwiftUI
import RealmSwift

struct Welcome: View {
    
    //@ObservedResults(RealmCoinGroup.self) var realmCoinGroups : Results<RealmCoinGroup>
    
    var body: some View {
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
                
                NavigationLink(destination: CoinListView()) {
                    Text("Fetch All Coins")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(20)
                }
                Spacer()
                
                
            }
            .navigationTitle("Welcome")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink(destination: CoinListView()) {
                        Text("Fetch")
                    }
                })
            }
    }
}

struct ScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Welcome()
        }
    }
}

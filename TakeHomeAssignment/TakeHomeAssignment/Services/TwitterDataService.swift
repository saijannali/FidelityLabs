//
//  TwitterDataService.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/13/23.
//

import Foundation
import Combine

class TwitterDataService: ObservableObject {
    
    @Published var tweets: Tweets? = nil
    
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getTweets(query: coin.coinName)
    }
    
    func getTweets(query: String) {
        guard let url = URL(string: "https://api.twitter.com/2/tweets/search/recent?query=%23\(query)") else{
            print(NetworkManager.NetworkingError.invalidURL)
            return
        }
        
        let BEARER_TOKEN = "AAAAAAAAAAAAAAAAAAAAAN%2FziwEAAAAAl2oSBrzZFMBl4gIkUed1Q%2BJC61U%3DS1pOF5tm9qvohyYm67qCIkf3GWrlNJ5RIJadP0g20vBACUslRq"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer " + BEARER_TOKEN, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(NetworkManager.NetworkingError.unknown)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200{
                print(NetworkManager.NetworkingError.badURLResponse(url: url))
                return
            }
            guard let fetchedTweets = try? JSONDecoder().decode(Tweets.self, from: data) else {return}
            DispatchQueue.main.async { [weak self] in
                self?.tweets = fetchedTweets
            }
        }
        .resume()
        
    }
}

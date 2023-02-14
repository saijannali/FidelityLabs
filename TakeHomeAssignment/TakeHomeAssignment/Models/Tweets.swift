//
//  Tweets.swift
//  TakeHomeAssignment
//
//  Created by Sai Jannali on 2/13/23.
//

import Foundation

struct Tweets: Codable {
    let data: [Tweet]
    let meta: Meta
}

struct Tweet: Codable, Identifiable {
    let editHistoryTweetIDS: [String]
    let id: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case editHistoryTweetIDS = "edit_history_tweet_ids"
        case id, text
    }
}

struct Meta: Codable {
    let newestID, oldestID: String
    let resultCount: Int
    let nextToken: String

    enum CodingKeys: String, CodingKey {
        case newestID = "newest_id"
        case oldestID = "oldest_id"
        case resultCount = "result_count"
        case nextToken = "next_token"
    }
}

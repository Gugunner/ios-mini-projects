//
//  Feed.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import Foundation

class FeedTester: FeedDelegate {

    private let dateFormatter: ISO8601DateFormatter = {
        return ISO8601DateFormatter()
    }()

    // MARK: - Feed Delegate test function
    func shout(feed: FeedModel) -> String {
        var shoutStringBuilder = [
            "author: \(feed.author)",
            "title: \(feed.title)",
            "type: \(feed.type)",
            "isoCreatedAt: \(dateFormatter.string(from: feed.createdAt))"
        ]

        if let textFeed = feed as? TextFeedModel {
            shoutStringBuilder.append("message: \(textFeed.message)")
        }

        if let postFeed = feed as? PostFeedModel {
            shoutStringBuilder.append("imagePath: \(postFeed.imagePath)")
            shoutStringBuilder.append("description: \(postFeed.description)")
        }

        let shoutString = shoutStringBuilder.joined(separator: "\n")
        return shoutString
    }
}

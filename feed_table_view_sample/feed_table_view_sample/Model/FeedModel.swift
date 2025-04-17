//
//  Feed.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import Foundation

enum FeedType: String {
    case text
    case post
    case unknown
}

protocol FeedProtocol {
    var author: String { get set }
    var title: String { get set }
    var createdAt: Date { get set }
    var type: FeedType { get set }
}

class FeedModel: FeedProtocol {
    var author: String
    var title: String
    var createdAt: Date
    var type: FeedType

    init(author: String, title: String, type: String, isoCreatedAt: String) {
        self.author = author
        self.title = title
        //Text is the default value used if type is not a valid enum case
        self.type = FeedType(rawValue: type) ?? FeedType.text
        self.createdAt = ISO8601DateFormatter().date(from: isoCreatedAt) ?? Date()
    }

}

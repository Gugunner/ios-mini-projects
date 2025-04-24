//
//  Text.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import Foundation

class TextFeedModel: FeedModel {

    let message: String

    init(identifier: UUID, author: String, title: String, message: String, type: String, isoCreatedAt: String) {
        self.message = message
        super.init(
            identifier: identifier,
            author: author,
            title: title,
            type: type,
            isoCreatedAt: isoCreatedAt
        )
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: FeedModelCoderKeys.self)
        message = try values.decode(String.self, forKey: .message)
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: FeedModelCoderKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(type, forKey: .type)
        try container.encode(isoCreatedAt, forKey: .isoCreatedAt)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(message, forKey: .message)
    }
}

//
//  Post.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//
import Foundation

class PostFeedModel: FeedModel {
    let imagePath: String
    let description: String

    init(identifier: UUID, author: String, title: String, imagePath: String, description: String, isoCreatedAt: String, type: String) {
        self.imagePath = imagePath
        self.description = description
        super.init(
            identifier: identifier,
            author: author,
            title: title,
            type: type,
            isoCreatedAt: isoCreatedAt
        )
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: FeedModelCodingKey.self)
        imagePath = try values.decode(String.self, forKey: .imagePath)
        description = try values.decode(String.self, forKey: .description)
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: FeedModelCodingKey.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(type, forKey: .type)
        try container.encode(isoCreatedAt, forKey: .isoCreatedAt)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(imagePath, forKey: .imagePath)
        try container.encode(description, forKey: .description)
    }
}

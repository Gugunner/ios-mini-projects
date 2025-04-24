//
//  FeedMode+FeedTypeCopy.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 23/04/25.
//

extension FeedModel {

    func toTypeModelIfFulfilled(message: String? = nil, imagePath: String? = nil, description: String? = nil) -> FeedModel {
        if let message = message, !message.isEmpty {
            return toTextFeedModel(message: message)
        }
        if let imagePath = imagePath, let description = description, !imagePath.isEmpty && !description.isEmpty {
            return toPostFeedModel(
                imagePath: imagePath,
                description: description
            )
        }
        return self
    }

    func toTextFeedModel(message: String) -> TextFeedModel {
        return TextFeedModel(
            identifier: self.identifier,
            author: self.author,
            title: self.title,
            message: message,
            type: self.type.rawValue,
            isoCreatedAt: self.isoCreatedAt        )
    }

    func toPostFeedModel(imagePath: String, description: String) -> PostFeedModel {
        return PostFeedModel(
            identifier: self.identifier,
            author: self.author,
            title: self.title,
            imagePath: imagePath,
            description: description,
            isoCreatedAt: self.isoCreatedAt,
            type: self.type.rawValue
        )
    }
}

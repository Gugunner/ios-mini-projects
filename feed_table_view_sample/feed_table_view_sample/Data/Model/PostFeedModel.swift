//
//  Post.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

class PostFeedModel: FeedModel {
    let imagePath: String
    let description: String

    init(author: String, title: String, imagePath: String, description: String, isoCreatedAt: String, type: String) {
        self.imagePath = imagePath
        self.description = description
        super.init(
            author: author,
            title: title,
            type: type,
            isoCreatedAt: isoCreatedAt
        )
    }
}

//
//  Text.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import Foundation

class TextFeedModel: FeedModel {

    let message: String

    init(author: String, title: String, message: String, type: String, isoCreatedAt: String) {
        self.message = message
        super.init(
            author: author,
            title: title,
            type: type,
            isoCreatedAt: isoCreatedAt
        )

    }

}

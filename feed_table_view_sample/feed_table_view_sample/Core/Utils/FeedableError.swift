//
//  FeedableError.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 22/04/25.
//

enum FeedableError: Error, Equatable {
    case missingValues(_ values: String)
    case cannotLoadFeed(_ message: String)
    case undefinedType
    case emptyFeed
    case emptyFeeds
}

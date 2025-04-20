//
//  FeedableProtocol.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

enum FeedableError: Error, Equatable {
    case missingValues(_ values: String)
    case cannotLoadFeed(_ message: String)
    case undefinedType
    case emptyFeed
    case emptyFeeds
}

protocol FeedLoaderProtocol {
    func loadAllFeeds(data: [[String:String]]) throws -> [FeedModel]
    func loadSingleFeed(_ datagram: [String:String]) throws -> FeedModel?
}

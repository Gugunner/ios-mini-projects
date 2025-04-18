//
//  FeedableProtocol.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

enum FeedableError: Error {
    case missingValues(_ values: String)
    case cannotLoadFeed(_ message: String)
    case unknownType
    case emptyFeed
    case emptyFeeds
}

protocol FeedLoaderProtocol {
    associatedtype Feed
    func loadAllFeeds(data: [[String:String]]) throws -> [Feed]
    func loadSingleFeed(_ datagram: [String:String]) throws -> Feed?
}

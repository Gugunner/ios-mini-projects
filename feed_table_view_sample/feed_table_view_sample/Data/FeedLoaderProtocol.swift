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
    var data: [FeedDatagram]? { get }
    var feeds: [FeedModel]? { get }
    func loadData() async throws //Use it to load data
    func loadAllFeeds() throws //Use it to load feeds
    func loadSingleFeed(_ datagram: FeedDatagram) throws -> FeedModel?
}

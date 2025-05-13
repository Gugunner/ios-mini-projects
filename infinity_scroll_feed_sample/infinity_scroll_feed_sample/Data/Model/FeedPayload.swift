//
//  FeedPayload.swift
//  infinity_scroll_feed_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

struct FeedPayload: PayloadProtocol {
    var page: Int
    var totalPages: Int
    let messages: [(String,String)]
}

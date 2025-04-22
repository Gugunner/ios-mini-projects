//
//  FeedDelegate.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

protocol FeedDelegate: AnyObject {
    associatedtype FeedModel
    func shout(feed: FeedModel) -> String
}

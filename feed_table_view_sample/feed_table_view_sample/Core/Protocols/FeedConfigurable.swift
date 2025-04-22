//
//  FeedConfigurable.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 16/04/25.
//

protocol FeedConfigurable {
    associatedtype FeedModel
    func configure(with feed: FeedModel)
}

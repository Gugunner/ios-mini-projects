//
//  FakeAppServiceContext.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 20/04/25.
//

class FakeAppServiceContext: AppServiceContext {
    var feedLoader: FeedLoaderProtocol = FakeFeedLoader()
}

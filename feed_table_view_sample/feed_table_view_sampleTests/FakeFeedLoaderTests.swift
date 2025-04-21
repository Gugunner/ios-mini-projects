//
//  FeedLoaderTests.swift
//  feed_table_view_sampleTests
//
//  Created by Raul_Alonzo on 18/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class FakeFeedLoaderTests: XCTestCase {

    private let loader = FakeFeedLoader()
    private var datagram = FeedLoaderSampleData.createSampleUnknowFeedDatagram()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loader.data = nil
        loader.feeds = nil
    }

    override func tearDownWithError() throws {
        // MARK: - Currently not in use
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadAllFeeds() throws {
        loader.data = FeedLoaderSampleData.createSampleData()
        try loader.loadAllFeeds()
        guard let feeds = loader.feeds else {
            return XCTFail("Feeds were not loaded")
        }
        XCTAssertIdentical(type(of: feeds[0]), PostFeedModel.self)
        XCTAssertIdentical(type(of: feeds[1]), TextFeedModel.self)
        XCTAssertEqual(feeds.count, loader.data?.count)
    }

    func testLoadAllFeedsRemovesErroFeeds() throws {
        var sampleData = FeedLoaderSampleData.createSampleData()
        sampleData[1] = sampleData[1].copy(type: "")
        sampleData[4] = sampleData[4].copy(author: "")
        loader.data = sampleData
        try loader.loadAllFeeds()
        guard let feeds = loader.feeds else {
            return XCTFail("Feeds were not loaded")
        }
        XCTAssertEqual(feeds.count, sampleData.count - 2)
    }

    func testLoadAllFeedsWithoutLoadingData() throws {
        XCTAssertThrowsError(try loader.loadAllFeeds()) { error in
            assertErrorAsFeedableErrorCase(error, case: .cannotLoadFeed("Data has not been loaded"))
        }
    }

    func testLoadAllFeedsFailWithEmpty() throws {
        loader.data = []
        XCTAssertThrowsError(try loader.loadAllFeeds()) { error in
            assertErrorAsFeedableErrorCase(error, case: .emptyFeeds)
        }
    }

    func testLoadUnknownFeedModel() throws {
        let feed = try loader.loadSingleFeed(datagram)
        assertEqualFeedFields(feed, datagram: datagram)
        XCTAssertEqual(feed?.type, FeedType.unknown)
        XCTAssertNil(feed as? TextFeedModel)
        XCTAssertNil(feed as? PostFeedModel)
    }

    func testLoadTextFeedModel() throws {
        let textDatagram = FeedLoaderSampleData.createSampleTextFeedDatagram()
        let feed = try loader.loadSingleFeed(textDatagram) as? TextFeedModel

        assertEqualFeedFields(feed, datagram: textDatagram)
        XCTAssertEqual(feed?.type, .text)
        XCTAssertEqual(feed?.message, textDatagram.message)
    }

    func testLoadPostFeedModel() throws {
        let postDatagram = FeedLoaderSampleData.createSamplePostFeedDatagram()
        let feed = try loader.loadSingleFeed(postDatagram) as? PostFeedModel
        
        assertEqualFeedFields(feed, datagram: postDatagram)
        XCTAssertEqual(feed?.type, .post)
        XCTAssertEqual(feed?.description, postDatagram.description)
        XCTAssertEqual(feed?.imagePath, postDatagram.imagePath)
    }

    func testLoadFeedModelFailsWithUndefinedType() throws {
        let failedDatagram = datagram.copy(type: "")
        XCTAssertThrowsError(try loader.loadSingleFeed(failedDatagram)) {
            error in assertErrorAsFeedableErrorCase(
                error,
                case: .cannotLoadFeed("The feed could not be loaded due to error: undefinedType")
            )
        }
    }

    func testLoadFeedModelFailsWithMissingValues() throws {
        let failedDatagram = datagram.copy(
            author: "Tester",
            title: "",
            type: "unknown",
            isoCreatedAt: ""
        )
        XCTAssertThrowsError(try loader.loadSingleFeed(failedDatagram)) {
            error in assertErrorAsFeedableErrorCase(
                error,
                case: .cannotLoadFeed("The feed is missing the following values: title, isoCreatedAt")
            )
        }
    }

    func testLoadTextFeedModelFailsWithMissingValues() throws {
        //$0 is keep curKey and $1 is keep newKey
        let failedTextDatagram = datagram.copy(type: "text")
        XCTAssertThrowsError(
            try loader.loadSingleFeed(failedTextDatagram)) { error in
                assertErrorAsFeedableErrorCase(error, case: .cannotLoadFeed("The feed is missing the following values: message"))
        }
    }

    func testLoadPostFeedModelFailsWithMissingValues() throws {
        //$0 is keep curKey and $1 is keep newKey
        let failedPostDatagram = datagram.copy(type: "post")
        XCTAssertThrowsError(try loader.loadSingleFeed(failedPostDatagram)){ error in assertErrorAsFeedableErrorCase(error, case: .cannotLoadFeed("The feed is missing the following values: description, imagePath"))
        }
    }

    private func assertEqualFeedFields(
        _ feed: FeedModel?,
        datagram data: FeedDatagram
    ) {
        XCTAssertEqual(feed?.author, data.author)
        XCTAssertEqual(feed?.title, data.title)
        
        if feed is TextFeedModel || feed is PostFeedModel {
            return XCTAssertEqual(
                feed?.createdAt,
                ISO8601DateFormatter().date(from: data.isoCreatedAt)
            )
        }

        //Special case when date is instantiated from todays date
        XCTAssertEqual(feed?.createdAt.iSO8601Midnight, data.isoCreatedAt)
    }

    private func assertErrorAsFeedableErrorCase(_ error: Error, case errorCase: FeedableError)  {
        guard let feedableError = error as? FeedableError else {
            return XCTFail("Error does not conform to a FeedableError")
        }
        XCTAssertEqual(feedableError, errorCase)
    }

    func testPerformanceExample() throws {
        // MARK: - Currently not in use
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

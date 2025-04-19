//
//  FeedLoaderTests.swift
//  feed_table_view_sampleTests
//
//  Created by Raul_Alonzo on 18/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class FeedLoaderTests: XCTestCase {

    private let loader = FeedLoader()
    private let datagram = ["author":"Tester", "title":"Simple Test", "type":"unknown", "isoCreatedAt":"2025-04-09T14:30:51+0000"]

    override func setUpWithError() throws {
        // MARK: - Currently not in use
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // MARK: - Currently not in use
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadUnknownFeedModel() throws {
        let unknownDatagram = FeedLoaderSampleData.createSampleUnknowFeedDatagram()
        let feed = try loader.loadSingleFeed(datagram)
        assertEqualFeedFields(feed, datagram: unknownDatagram)
        XCTAssertEqual(feed?.type, FeedType.unknown)
        XCTAssertNil(feed as? TextFeedModel)
        XCTAssertNil(feed as? PostFeedModel)
    }

    func testLoadTextFeedModel() throws {
        let textDatagram = FeedLoaderSampleData.createSampleTextFeedDatagram()
        let feed = try loader.loadSingleFeed(textDatagram) as? TextFeedModel

        assertEqualFeedFields(feed, datagram: textDatagram)
        XCTAssertEqual(feed?.type, .text)
        XCTAssertEqual(feed?.message, textDatagram["message"])
    }

    func testLoadPostFeedModel() throws {
        let postDatagram = FeedLoaderSampleData.createSamplePostFeedDatagram()
        let feed = try loader.loadSingleFeed(postDatagram) as? PostFeedModel
        
        assertEqualFeedFields(feed, datagram: postDatagram)
        XCTAssertEqual(feed?.type, .post)
        XCTAssertEqual(feed?.description, postDatagram["description"])
        XCTAssertEqual(feed?.imagePath, postDatagram["imagePath"])
    }

    private func assertEqualFeedFields(_ feed: FeedModel?, datagram data: [String:String]) {
        XCTAssertEqual(feed?.author, data["author"])
        XCTAssertEqual(feed?.title, data["title"])
        
        guard let isoCreatedAt = data["isoCreatedAt"] else {
            return XCTFail("isoCreatedAt is not present in the datagram to test equality")
        }
        
        if feed is TextFeedModel || feed is PostFeedModel {
            return XCTAssertEqual(
                feed?.createdAt,
                ISO8601DateFormatter().date(from: isoCreatedAt)
            )
        }

        //Special case when date is instantiated from todays date
        XCTAssertEqual(feed?.createdAt.iSO8601Midnight, isoCreatedAt)
    }

    func testLoadFeedModelFailsWithEmpty() throws {
        XCTAssertThrowsError(try loader.loadSingleFeed([:])) { error in
            assertErrorAsFeedableErrorCase(error, case: .cannotLoadFeed("The feed could not be loaded due to error: emptyFeed"))
        }
    }

    func testLoadFeedModelFailsWithUndefinedType() throws {
        let failedDatagram = ["author":"Tester"]
        XCTAssertThrowsError(try loader.loadSingleFeed(failedDatagram)) {
            error in assertErrorAsFeedableErrorCase(
                error,
                case: .cannotLoadFeed("The feed could not be loaded due to error: undefinedType")
            )
        }
    }

    func testLoadFeedModelFailsWithMissingValues() throws {
        let failedDatagram = ["author":"Tester", "type":""]
        XCTAssertThrowsError(try loader.loadSingleFeed(failedDatagram)) {
            error in assertErrorAsFeedableErrorCase(
                error,
                case: .cannotLoadFeed("The feed is missing the following values: title, type, isoCreatedAt")
            )
        }
    }

    func testLoadTextFeedModelFailsWithMissingValues() throws {
        //$0 is keep curKey and $1 is keep newKey
        let failedTextDatagram = datagram.merging(["type":"text"]) { $1 }
        XCTAssertThrowsError(
            try loader.loadSingleFeed(failedTextDatagram)) { error in
                assertErrorAsFeedableErrorCase(error, case: .cannotLoadFeed("The feed is missing the following values: message"))
        }
    }

    func testLoadPostFeedModelFailsWithMissingValues() throws {
        //$0 is keep curKey and $1 is keep newKey
        let failedPostDatagram = datagram.merging(["type":"post"]) { $1 }
        XCTAssertThrowsError(try loader.loadSingleFeed(failedPostDatagram)){ error in assertErrorAsFeedableErrorCase(error, case: .cannotLoadFeed("The feed is missing the following values: imagePath, description"))
        }
    }
    
    func testLoadAllFeeds() throws {
        let sampleData = FeedLoaderSampleData.createSampleData()
        let feeds = try loader.loadAllFeeds(data: sampleData)
        XCTAssertIdentical(type(of: feeds[0]), PostFeedModel.self)
        XCTAssertIdentical(type(of: feeds[1]), TextFeedModel.self)
    }

    func testLoadAllFeedsRemovesErroFeeds() throws {
        var sampleData = FeedLoaderSampleData.createSampleData()
        sampleData[1] = [:]
        sampleData[4]["author"] = ""
        let feeds = try loader.loadAllFeeds(data: sampleData)
        XCTAssertTrue(feeds.count == sampleData.count - 2)
    }

    func testLoadAllFeedsFailWithEmpty() throws {
        XCTAssertThrowsError(try loader.loadAllFeeds(data: [])) { error in
            assertErrorAsFeedableErrorCase(error, case: .emptyFeeds)
        }
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

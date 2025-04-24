//
//  PostFeedModelTests.swift
//  feed_table_view_sampleTests
//
//  Created by Raul_Alonzo on 24/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class PostFeedModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodePostFeedModel() {
        guard let decodedData:[FeedModel] = try? Bundle.main.decode(with: "feeds.json") else {
            return XCTFail("The feed models could not be decoded")
        }
        let filteredPostFeeds:[PostFeedModel] = decodedData.filter {
            $0.type == .post
        }.map { $0.toPostFeedModel(imagePath: "testPath", description: "test description") }
        if filteredPostFeeds.isEmpty {
            return XCTFail("There are no post feeds")
        }
        XCTAssertEqual(filteredPostFeeds.count, 2)
        XCTAssertEqual(filteredPostFeeds[0].identifier.uuidString, "E09FFBD4-318F-46EE-8FA2-FA387D4F3563")
    }

    func testEncodePostFeedModel() {
        let postFeed = FeedModel().toPostFeedModel(imagePath: "testPath", description: "test description")
        let encoder = JSONEncoder()
        XCTAssertNoThrow(try encoder.encode(postFeed))
    }
}

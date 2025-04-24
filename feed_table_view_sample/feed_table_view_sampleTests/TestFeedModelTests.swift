//
//  TestFeedModelTests.swift
//  feed_table_view_sampleTests
//
//  Created by Raul_Alonzo on 24/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class TestFeedModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeTextFeedModel() {
        guard let decodedData:[FeedModel] = try? Bundle.main.decode(with: "feeds.json") else {
            return XCTFail("The feed models could not be decoded")
        }
        let filteredTextFeeds:[TextFeedModel] = decodedData.filter {
            $0.type == .text
        }.map { $0.toTextFeedModel(message: "Test message") }
        if filteredTextFeeds.isEmpty {
            return XCTFail("There are no text feeds")
        }
        XCTAssertEqual(filteredTextFeeds.count, 2)
        XCTAssertEqual(filteredTextFeeds[0].identifier.uuidString, "E09FFBD4-318F-46EE-8FA2-FA387D4F3562")
    }

    func testEncodeTextFeedModel() {
        let textFeed = FeedModel().toTextFeedModel(message: "Test message")
        let encoder = JSONEncoder()
        XCTAssertNoThrow(try encoder.encode(textFeed))
    }
}

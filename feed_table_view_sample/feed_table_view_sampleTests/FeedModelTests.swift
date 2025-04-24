//
//  FeedModelTests.swift
//  feed_table_view_sampleTests
//
//  Created by Raul_Alonzo on 24/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class FeedModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeFeedModel() {
        guard let decodedData:[FeedModel] = try? Bundle.main.decode(with: "feeds.json") else {
            return XCTFail("The feed models could not be decoded")
        }
        XCTAssertEqual(decodedData.count, 4)
        XCTAssertEqual(
            decodedData[0].identifier.uuidString,
            "E09FFBD4-318F-46EE-8FA2-FA387D4F3562"
        )
    }

    func testEncodeFeedModelFails() {
        let feed = FeedModel()
        let encoder = JSONEncoder()
        XCTAssertThrowsError(try encoder.encode(feed)) { error in
            XCTAssertTrue(error is FeedableError)
            assertErrorAsFeedableErrorCase(error, case: .notEncodable)
        }
    }
}

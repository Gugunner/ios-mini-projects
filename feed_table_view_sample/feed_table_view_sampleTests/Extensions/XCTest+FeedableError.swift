//
//  XCTest+FeedableError.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 24/04/25.
//

import XCTest
@testable import feed_table_view_sample

extension XCTest {
    func assertErrorAsFeedableErrorCase(_ error: Error, case errorCase: FeedableError)  {
        guard let feedableError = error as? FeedableError else {
            return XCTFail("Error does not conform to a FeedableError")
        }
        XCTAssertEqual(feedableError, errorCase)
    }
}

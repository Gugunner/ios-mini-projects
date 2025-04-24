//
//  FeedLoaderSampleData.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 19/04/25.
//

import Foundation
@testable import feed_table_view_sample

class FeedLoaderSampleData {
    static func createSampleData() -> [FeedDatagram] {
        return (1...9).map() { v in
            if v % 2 == 0 {
                return FeedLoaderSampleData.createSampleTextFeedDatagram(suffix: "\(v)")
            }
            return FeedLoaderSampleData.createSamplePostFeedDatagram(suffix: "\(v)")
        }
    }

    static func createSampleTextFeedDatagram(suffix: String = "") -> FeedDatagram {
        return FeedDatagram(
            author: "Tester\(suffix)",
            title: "Simple Test \(suffix)",
            type: "text",
            isoCreatedAt: "2025-04-09T14:30:51+0000",
            message: "A simple test message \(suffix)"
        )
    }

    static func createSamplePostFeedDatagram(suffix: String = "") -> FeedDatagram {
        return FeedDatagram(
            author: "Tester\(suffix)",
            title: "Simple Test \(suffix)",
            type: "post",
            isoCreatedAt: "2025-04-09T14:30:51+0000",
            description: "Test description \(suffix)",
            imagePath: "testPath\(suffix)"
        )
    }

    static func createSampleUnknowFeedDatagram() -> FeedDatagram {
        return FeedDatagram(
            author: "Unknown",
            title: "No title",
            type: "unknown",
            isoCreatedAt: Date().iSO8601Midnight
        )
    }
}

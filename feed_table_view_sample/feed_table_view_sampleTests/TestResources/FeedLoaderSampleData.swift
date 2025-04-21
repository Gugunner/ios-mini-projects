//
//  FeedLoaderSampleData.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 19/04/25.
//

import Foundation

class FeedLoaderSampleData {
    static func createSampleData() -> [[String:String]] {
        return (1...9).map() { v in
            if v % 2 == 0 {
                return FeedLoaderSampleData.createSampleTextFeedDatagram(suffix: "\(v)")
            }
            return FeedLoaderSampleData.createSamplePostFeedDatagram(suffix: "\(v)")
        }
    }

    static func createSampleTextFeedDatagram(suffix: String = "") -> [String:String] {
        return ["author":"Tester\(suffix)", "title":"Simple Test \(suffix)",
                "message":"A simple test message \(suffix)", "type":"text", "isoCreatedAt":"2025-04-09T14:30:51+0000"]
    }

    static func createSamplePostFeedDatagram(suffix: String = "") -> [String:String] {
        return ["author":"Tester\(suffix)", "title":"Simple Test \(suffix)",
                "description":"Test description \(suffix)",
                "imagePath":"testPath\(suffix)", "type":"post", "isoCreatedAt":"2025-04-09T14:30:51+0000"]
    }

    static func createSampleUnknowFeedDatagram() -> [String: String] {
        return [
            "author":"Unknown",
            "title":"No title",
            "type":"unknown",
            "isoCreatedAt":Date().iSO8601Midnight
        ]
    }
}

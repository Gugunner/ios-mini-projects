//
//  DateISO8601.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 19/04/25.
//

import Foundation

extension Date {
    var iSO8601Midnight: String {
        let today = Calendar(identifier: .gregorian).startOfDay(for: self)
        return today.formatted(
            .iso8601
                .year()
                .month()
                .day()
                .time(includingFractionalSeconds: false)
                .timeSeparator(.colon)
                .dateSeparator(.dash)
                .dateTimeSeparator(.standard)
                .timeZone(separator: .colon)
        )
    }
}

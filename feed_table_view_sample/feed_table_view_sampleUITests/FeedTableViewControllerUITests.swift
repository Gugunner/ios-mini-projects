//
//  FeedTableViewControllerUITests.swift
//  feed_table_view_sampleUITests
//
//  Created by Raul_Alonzo on 19/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class FeedTableViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadsAllFeedsInTableView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let window = app.windows["MainWindow"]
        XCTAssertTrue(window.exists)
        let tables = window.tables
        XCTAssertEqual(tables.count, 1)
        let table = tables.firstMatch
        XCTAssertTrue(table.exists)
        let cells = table.cells
        XCTAssertEqual(cells.count, 4)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFirstTableViewCellIsOfTypeText() {
        let app = XCUIApplication()
        app.launch()
        let window = app.windows["MainWindow"]
        let firstCell = window.tables.firstMatch.cells.firstMatch
        XCTAssertEqual(firstCell.identifier, "TextFeedCell_0")
    }

    func testSecondTableViewCellIsOfTypePost() {
        let app = XCUIApplication()
        app.launch()
        let window = app.windows["MainWindow"]
        let secondCell = window.tables.firstMatch.cells.element(boundBy: 1)
        XCTAssertEqual(secondCell.identifier, "PostFeedCell_1")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

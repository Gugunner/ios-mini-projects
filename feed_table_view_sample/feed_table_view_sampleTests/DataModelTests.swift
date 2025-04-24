//
//  DataModelTests.swift
//  feed_table_view_sampleTests
//
//  Created by Raul_Alonzo on 24/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class DataModelTests: XCTestCase {

    let file = "feeds.json"
    var dataModel = DataModel<FeedModel>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataModel.data = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeDataModelOfFeedModelFromFile() {
        guard let dm = try? DataModel<FeedModel>(withFile: file), !dm.data.isEmpty else {
            return XCTFail("DataModel could not be loaded from file")
        }
        XCTAssertFalse(dm.data.isEmpty)
        XCTAssertEqual(dm.data[0].identifier.uuidString, "E09FFBD4-318F-46EE-8FA2-FA387D4F3562")
    }

    func testDecodeDataModelOfFeedModelFromFileFail() {
        XCTAssertThrowsError(try DataModel<FeedModel>(withFile: "error.json")) { error in
            if let dataModelError = error as? DataModelError {
                XCTAssertEqual(dataModelError, DataModelError.cannotLoadUrl("Cannot load the url from error.json"))
            }
        }
    }

    func testDataModelDataIsEmpty() {
        XCTAssertTrue(DataModel<FeedModel>().data.isEmpty)
    }

    func testEncodeDataModelOfFeedModelSubclasses() {
        //Test with a subclass of feed model since FeedModel is not encodable
        let textFeedModel = FeedModel().toTextFeedModel(message: "Test")
        let postFeedModel = FeedModel().toPostFeedModel(
            imagePath: "testPath",
            description: "test description"
        )
        dataModel.data.append(textFeedModel)
        dataModel.data.append(postFeedModel)
        let encoder = JSONEncoder()
        XCTAssertNoThrow(try encoder.encode(dataModel))
    }

    func testEncodeDataModelWithEmptyDataFail() {
        let encoder = JSONEncoder()
        XCTAssertThrowsError(try encoder.encode(dataModel))
    }

    func testEncodeDataModelOfFeedModelFail() {
        dataModel.data.append(FeedModel())
        let encoder = JSONEncoder()
        XCTAssertThrowsError(try encoder.encode(dataModel)) { error in
            assertErrorAsFeedableErrorCase(
                error,
                case: FeedableError.notEncodable
            )
        }
    }
}

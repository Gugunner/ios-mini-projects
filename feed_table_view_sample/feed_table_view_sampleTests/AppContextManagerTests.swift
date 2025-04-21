//
//  AppContextManagerTests.swift
//  feed_table_view_sampleTests
//
//  Created by Raul_Alonzo on 20/04/25.
//

import XCTest
@testable import feed_table_view_sample

final class AppContextManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppContextManagerConfiguresWithMockAppContext() throws {
        AppContextManager.app.configure(with: FakeAppContext())
        XCTAssertTrue(AppContextManager.app.shared is FakeAppContext)
    }

    func testAppContextManagerFailsIfNotConfigured() throws {
        expectTestFatalErrorMessageToBe("App context must be configured before use.") {
            let _ = AppContextManager.app.shared
        }
    }

    private func expectTestFatalErrorMessageToBe(_ expectedMessage: String, test: @escaping () -> Void) {
        let expect = XCTestExpectation(description: "Expect call to fatalError")

        FatalErrorUtil.replaceFatalError { message, _, _ in
            XCTAssertEqual(message, expectedMessage)
            expect.fulfill()
            ThreadUtil.assertNotOnMainThread()
            FatalErrorUtil.returnsNever()//Satisfies returning never
        }

        DispatchQueue.global(qos: .userInitiated).async {
            test()
        }
        wait(for: [expect], timeout: 1.0)
        addTeardownBlock {
            FatalErrorUtil.restoreFatalError()
        }
    }
}

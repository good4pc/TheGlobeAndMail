//
//  TheGlobeAndMailUITests.swift
//  TheGlobeAndMailUITests
//
//  Created by Prasanth pc on 2024-10-23.
//

import XCTest
@testable import TheGlobeAndMail

final class TheGlobeAndMailUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchEnvironment["UITESTING"] = "1"
        app.launch()

        MockUrlProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = "{ \"key\": \"value\" }".data(using: .utf8)!
            return (response, data)
        }
    }
}

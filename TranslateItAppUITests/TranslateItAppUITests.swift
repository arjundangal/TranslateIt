//
//  TranslateItAppUITests.swift
//  TranslateItAppUITests
//
//  Created by Arjun Dangal on 23/7/2022.
//

import XCTest

class TranslateItAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    
    func testUIElementsExist() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.staticTexts["correctLabel"].exists)
        XCTAssertTrue(app.staticTexts["incorrectLabel"].exists)
        XCTAssertTrue(app.staticTexts["titleLabel"].exists)
        XCTAssertTrue(app.staticTexts["questionLabel"].exists)
        XCTAssertTrue(app.buttons["correctButton"].exists)
        XCTAssertTrue(app.buttons["incorrectButton"].exists)

    }

   
}

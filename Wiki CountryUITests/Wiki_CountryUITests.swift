//
//  Wiki_CountryUITests.swift
//  Wiki CountryUITests
//
//  Created by BoFu on 11/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import XCTest

class Wiki_CountryUITests: XCTestCase {

    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMainScreen() {
        let labelText = app.staticTexts["Country list"]
        XCTAssertTrue(labelText.exists, "Should be in the main screen")
    }
    
    
}

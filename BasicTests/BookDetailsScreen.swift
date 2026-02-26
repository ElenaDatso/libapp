//
//  BookDetailsScreen.swift
//  BasicTests
//
//  Created by Elena Datso on 2026-02-25.
//

import XCTest

final class BookDetailsTests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        navigateToDetails()
    }

    func testDetailsScreenDisplaysTitle() {
        XCTAssertTrue(app.staticTexts["bookTitle"].exists)
    }

    func testBackButtonReturnsToList() {
        app.buttons["Back"].tap()
        XCTAssertTrue(app.navigationBars["Books"].exists)
    }


    private func navigateToDetails() {
        app.cells.firstMatch.tap()
    }
}

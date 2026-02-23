//
//  BasicTests.swift
//  BasicTests
//
//  Created by Elena Datso on 2026-02-22.
//

//
//  _UITests.swift
//  1UITests
//
//  Created by Elena Datso on 2026-02-22.
//

import XCTest

final class LibraryAppUITests: XCTestCase {

    func testSearchFlow() {
        let app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launch()

        let textField = app.textFields["searchTextField"]
        XCTAssertTrue(textField.waitForExistence(timeout: 3))

        textField.tap()
        textField.typeText("Harry Potter")

        let button = app.buttons["searchButton"]
        button.tap()

        let collectionView = app.collectionViews["booksCollectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
    }
    
    func testSearchShowsResults() {
        let app = XCUIApplication()
        app.launch()

        let textField = app.textFields["searchTextField"]
        textField.tap()
        textField.typeText("Swift")

        app.buttons["searchButton"].tap()

        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
    }
    
    func testEmptyQueryDoesNotCrash() {
        let app = XCUIApplication()
        app.launch()

        let button = app.buttons["searchButton"]
        button.tap()

        let collectionView = app.collectionViews["booksCollectionView"]
        XCTAssertTrue(collectionView.exists)
    }

}

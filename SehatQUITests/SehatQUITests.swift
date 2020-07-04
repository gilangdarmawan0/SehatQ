//
//  SehatQUITests.swift
//  SehatQUITests
//
//  Created by Gilang Darmawan on 02/07/20.
//  Copyright © 2020 SehatQ. All rights reserved.
//

import XCTest

class SehatQUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLoginUsingUsername(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let userNameTextField = app.textFields["Username"]
        userNameTextField.tap()
        userNameTextField.typeText("test")
        sleep(2)
        let passwordSecureTextField = app.secureTextFields["Password"]
        UIPasteboard.general.string = "the password"
        passwordSecureTextField.doubleTap()
        app.menuItems["Paste"].tap()
        
        let showPassword = app.buttons["ic visibleOff"]
        let hidePassword = app.buttons["ic visibleOn"]
        sleep(2)
        showPassword.tap()
        sleep(2)
        hidePassword.tap()
        sleep(2)
        let loginButton = app.buttons["Sign In"]
        loginButton.tap()
        sleep(2)
    }
    
    func testLookDashboardProductDetail(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 0).swipeUp()
        sleep(2)
        app.tables.staticTexts["Nitendo Switch"].tap()
        sleep(2)
        app.buttons["ic back"].tap()
        sleep(2)
    }

    func testLookSearchProductDetail(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        sleep(2)
        app.searchFields.element.tap()
        app.searchFields.element.tap()
        UIPasteboard.general.string = "nitendo"
        app.menuItems["Paste"].tap()
        sleep(2)
        app.tables.staticTexts["Nitendo Switch"].tap()
        app.buttons["ic back"].tap()
        sleep(2)
    }

    func testLookHistoryProductDetail(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["Profile"].tap()
        sleep(2)
        app.tables.staticTexts["Nitendo WII "].tap()
        sleep(2)
        app.buttons["ic back"].tap()
        sleep(2)
        let button = app.navigationBars["SehatQ.ProductHistoryView"].children(matching: .button).element
        button.tap()
        sleep(2)
    }

    func testLookProductSearch(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        sleep(2)
        app.buttons["ic back"].tap()
        sleep(2)
    }

    func testLookPurchasedHistory(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["Profile"].tap()
        sleep(2)
        let button = app.navigationBars["SehatQ.ProductHistoryView"].children(matching: .button).element
        button.tap()
        sleep(2)
    }

    func testSearchProduct(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()
        sleep(2)
        app.searchFields.element.tap()
        app.searchFields.element.tap()
        UIPasteboard.general.string = "nitendo"
        app.menuItems["Paste"].tap()
        sleep(2)
    }
    
    func testChooseFavouriteProductDetail(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 0).swipeUp()
        sleep(2)
        app.tables.staticTexts["Nitendo Switch"].tap()
        sleep(2)
        let icLoveEmptyButton = app.buttons["ic love empty"]
        icLoveEmptyButton.tap()
        sleep(2)
        let icLoveFillButton = app.buttons["ic love fill"]
        icLoveFillButton.tap()
        sleep(2)
    }

    func testChooseFavouriteProductDashboard(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.containing(.staticText, identifier:"Nitendo Switch").buttons["ic love empty"].tap()
        sleep(2)
        tablesQuery.cells.containing(.staticText, identifier:"Nitendo Switch").buttons["ic love fill"].tap()
        sleep(2)
    }

    func testChooseFavouriteDashboard(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let element = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .button)["ic love empty"].tap()
        sleep(2)
        element.children(matching: .button)["ic love fill"].tap()
        sleep(2)
    }

    func testShareProductDetail(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 0).swipeUp()
        sleep(2)
        app.tables.staticTexts["Nitendo Switch"].tap()
        sleep(2)
        app.buttons["ic share"].tap()
        sleep(2)
        app.navigationBars["UIActivityContentView"].buttons["Close"].tap()
        sleep(2)
    }

    func testSwipeProductCategory(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let element = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 0)
        element.swipeLeft()
        sleep(2)
        element.swipeRight()
        sleep(2)
    }

    func testSwipeProductDashboard(){
//        let app = XCUIApplication()
//        app.launch()
//        sleep(2)
//        let element = XCUIApplication().tables.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 0)
//        element.swipeUp()
//        sleep(2)
//        element.swipeDown()
//        sleep(2)
    }

    func testBuyProduct(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 0).swipeUp()
        sleep(2)
        app.tables.staticTexts["Nitendo Switch"].tap()
        sleep(2)
        app.buttons["Buy"].tap()
        sleep(2)
        app.buttons["ic back"].tap()
    }
    
    func testRefreshHome(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["Home"].tap()
        sleep(2)
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

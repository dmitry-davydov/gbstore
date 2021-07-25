//
//  LoginUITests.swift
//  GBStoreUITests
//
//  Created by Дима Давыдов on 26.07.2021.
//

import XCTest

class LoginUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        
        let usernameTextField = elementsQuery.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("Test")
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("test")
        
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Submit"]/*[[".buttons[\"Submit\"].staticTexts[\"Submit\"]",".staticTexts[\"Submit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(3)
        XCTAssertTrue(app.buttons["Products"].exists)
    }

}

//
//  TodoAppUITests.swift
//  TodoAppUITests
//
//  Created by wtildestar on 06/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import XCTest

class TodoAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test.
        app = XCUIApplication()
        app.launchArguments.append("--UITesting")
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        
        // проверяю нахожусь ли на главном экране или нет по идентификатору view
        XCTAssertTrue(app.isOnMainView)
        
        app.navigationBars["TodoApp.TaskListView"].buttons["Add"].tap()
        
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Нью-Йорк")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.19")
        
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Bar")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")
        
        XCTAssertFalse(app.isOnMainView)
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.tables.staticTexts["Foo"].exists)
        XCTAssertTrue(app.tables.staticTexts["Bar"].exists)
        XCTAssertTrue(app.tables.staticTexts["01.01.19"].exists)
    }
    
    func testWhenCellIsSwipedLeftDoneButtonAppeared() {
        // проверяю нахожусь ли на главном экране или нет по идентификатору view
        XCTAssertTrue(app.isOnMainView)
        
        app.navigationBars["TodoApp.TaskListView"].buttons["Add"].tap()
        
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("Foo")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("Нью-Йорк")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.19")
        
        app.textFields["Address"].tap()
        app.textFields["Address"].typeText("Bar")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("Baz")
        
        XCTAssertFalse(app.isOnMainView)
        app/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.isOnMainView)
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft() // boundBy индекс
        tablesQuery.element(boundBy: 0).buttons["Done"].tap()
        
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "date").label, "")
        
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


extension XCUIApplication {
    var isOnMainView: Bool {
        return otherElements["mainView"].exists
    }
}

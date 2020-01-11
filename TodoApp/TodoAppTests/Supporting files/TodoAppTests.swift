//
//  TodoAppTests.swift
//  TodoAppTests
//
//  Created by wtildestar on 06/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import XCTest
@testable import TodoApp

class TodoAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialViewControllerIsTaskListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootVC = navigationController.viewControllers.first as! TaskListViewController
        
        XCTAssertTrue(rootVC is TaskListViewController)
    }

}

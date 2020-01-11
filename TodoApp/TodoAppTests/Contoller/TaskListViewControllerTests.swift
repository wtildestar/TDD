//
//  TaskListViewControllerTests.swift
//  TodoAppTests
//
//  Created by wtildestar on 07/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import XCTest
@testable import TodoApp

class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        
        // Вызываю viewDidLoad
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    // проверяю что DataProvider является одним экземпляром для обоих протоколов
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSource() {
        XCTAssertEqual(
            sut.tableView.delegate as? DataProvider,
            sut.tableView.dataSource as? DataProvider)
    }
    
    // проверка на кнопку addButton
    func testTaskListVCHasAddButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func testAddNewTaskPresentsNewTaskViewController() {
        // проверка на доп вьюконтроллеры
        XCTAssertNil(sut.presentedViewController)
        
        // если добраться до кнопки не получилось и экшена у кнопки нет то фейл
        guard
            let newTaskButton = sut.navigationItem.rightBarButtonItem,
            let action = newTaskButton.action else {
                XCTFail()
                return
        }
        
        // делаю sut в качестве root viewcontroller'a window
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        // если есть кнопка с экшеном выполняем экшен
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        // проверяю наличие контроллера
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is NewTaskViewController)
        
        let newTaskViewController = sut.presentedViewController as! NewTaskViewController
        // делаю проверку на аутлет
        XCTAssertNotNil(newTaskViewController.titleTextField)
    }
}

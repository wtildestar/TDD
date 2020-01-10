//
//  APIClientTests.swift
//  TodoAppTests
//
//  Created by wtildestar on 10/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import XCTest
@testable import TodoApp

class APIClientTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func userLogin() {
        let mockURLSession = MockURLSession()
        let sut = APIClient()
        sut.urlSession = mockURLSession
        
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "qwerty", completionHandler: completionHandler)
        
        //  могу ли вытащить урл с mockURLSession
        
    }
    
    // проверка когда пользователь логинится сервер использует правильный host
    func testLoginUsesCorrectHost() {
        userLogin()
        XCTAssertEqual(urlComponents?.host, "todoapp.com")
    }
    
    func testLoginUsesCorrectPath() {
        userLogin()
        XCTAssertEqual(urlComponents?.path, "/login")
    }

}

extension APIClientTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            
            return URLSession.shared.dataTask(with: url)
        }
    }
}

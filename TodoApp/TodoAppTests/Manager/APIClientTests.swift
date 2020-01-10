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
    
    let mockURLSession = MockURLSession()
    let sut = APIClient()
    
    
    override func setUp() {
        sut.urlSession = mockURLSession
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func userLogin() {
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "qwerty", completionHandler: completionHandler)
    }
    
    // проверка когда пользователь логинится сервер использует правильный host
    func testLoginUsesCorrectHost() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    
    func testLoginUsesCorrectPath() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }

    func testLoginUsesExpectedQueryParameters() {
        userLogin()
        guard let queryItems = mockURLSession.urlComponents?.queryItems else {
            XCTFail()
            return
        }
        let urlQueryItemName = URLQueryItem(name: "name", value: "name")
        let urlQueryItemPassword = URLQueryItem(name: "password", value: "qwerty")
        
        XCTAssertTrue(queryItems.contains(urlQueryItemName))
        XCTAssertTrue(queryItems.contains(urlQueryItemPassword))
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

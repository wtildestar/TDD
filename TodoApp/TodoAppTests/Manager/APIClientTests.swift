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
    
    var mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
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
    
    // token -> Data -> completionHandler -> DataTask -> urlSession
    func testSuccessfulLoginCreatesToken() {
        // создаю токен, получаю в качестве ответа с сервера
        let jsonDataStub = "{\"token\": \"tokenString\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
        sut.urlSession = mockURLSession
        // создаю ожидание
        let tokenExpectation = expectation(description: "Token expectation")
        
        var caughtToken: String?
        sut.login(withName: "login", password: "password") { token, _ in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken, "tokenString")
        }
    }
}

extension APIClientTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        
        private let mockDataTask: MockURLSessionDataTask
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            
//            return URLSession.shared.dataTask(with: url)
            // беру completionHandler из dataTask выше и помещаю в mockDataTask
            mockDataTask.completionHandler = completionHandler
            return mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler? (
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}

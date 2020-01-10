//
//  APIClient.swift
//  TodoApp
//
//  Created by wtildestar on 10/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "https://todoapp.com/login") else {
            fatalError()
        }
        
        urlSession.dataTask(with: url) { (data, resonse, error) in
            
        }.resume()
    }
}

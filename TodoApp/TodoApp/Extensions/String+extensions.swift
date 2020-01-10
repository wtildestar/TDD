//
//  String+extensions.swift
//  TodoApp
//
//  Created by wtildestar on 10/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "~!@#$%^&*()-+=[]\\{},./?><").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        return encodedString
    }
}

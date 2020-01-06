//
//  DataProvider.swift
//  TodoApp
//
//  Created by wtildestar on 07/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class DataProvider: NSObject {
    
}

extension DataProvider: UITableViewDelegate {
    
}

extension DataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

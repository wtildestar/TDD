//
//  ViewController.swift
//  TodoApp
//
//  Created by wtildestar on 06/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet var dataProvider: DataProvider!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            viewController.taskManager = self.dataProvider.taskManager
            present(viewController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
    }

}


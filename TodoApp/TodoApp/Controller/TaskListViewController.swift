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
    @IBOutlet var tableView: UITableView!
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail(withNotification:)), name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc
    func showDetail(withNotification notification: Notification) {
        // проверю что у notification есть словарь userInfo
        guard
            let userInfo = notification.userInfo,
            // достаю таск из userInfo
            let task = userInfo["task"] as? Task,
            let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {
                fatalError()
        }
        detailVC.task = task
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


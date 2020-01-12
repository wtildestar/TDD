//
//  TaskManager.swift
//  TodoApp
//
//  Created by wtildestar on 06/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import Foundation
import UIKit

class TaskManager {
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    var tasksURL: URL {
        // где хрянятся все файлы
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else {
            fatalError()
        }
        
        return documentURL.appendingPathComponent("tasks.plist")
    }
    
    init() {
        // регистрирую себя в качестве наблюдателя в инициализаторе
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        
        // получаю данные
        if let data = try? Data(contentsOf: tasksURL) {
            // получаю словари который хранятся в данном файле
            let dictionaries = try? PropertyListSerialization.propertyList(from: data,
                                                                           options: [],
                                                                        format: nil) as! [[String : Any]] // привожу к массиву словарей
            // использую словари для создания тасков
            for dict in dictionaries! {
                if let task = Task(dict: dict) {
                    tasks.append(task)
                }
            }
        }
    }
    
    deinit {
        save()
    }
    
    @objc
    func save() {
        // все таски которые есть превратить в словари
        let taskDictionaries = self.tasks.map { $0.dict }
        // проверка на наличие элементов
        guard taskDictionaries.count > 0 else {
            // если задач нет удаляю все что хранится в файле
            try? FileManager.default.removeItem(at: tasksURL)
            return
        }
        
        // получаю taskDictionaries в формате xml
        let plistData = try? PropertyListSerialization.data(fromPropertyList: taskDictionaries,
                                                            format: .xml,
                                                            options: PropertyListSerialization.WriteOptions(0))
        // после получения пытаюсь сохранить
        try? plistData?.write(to: tasksURL, options: .atomic)
    }
    
    func add(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        // _ тк remove возвращает элемент
        let task = tasks.remove(at: index)
        doneTasks.append(task)
    }
    
    func uncheckTask(at index: Int) {
        // _ тк remove возвращает элемент
        let task = doneTasks.remove(at: index)
        tasks.append(task)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}

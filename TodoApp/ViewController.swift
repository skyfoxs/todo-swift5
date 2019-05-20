//
//  ViewController.swift
//  TodoApp
//
//  Created by Supakit Thanadittagorn on 20/5/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var todo = Todo()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.totalItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        todo.add(item: TodoItem(title: "Buy milk"))
        todo.add(item: TodoItem(title: "Learning Swift", isDone: false))
    }
}


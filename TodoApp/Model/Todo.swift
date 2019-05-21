//
//  Todo.swift
//  TodoApp
//
//  Created by Supakit Thanadittagorn on 20/5/19.
//  Copyright © 2019 pop. All rights reserved.
//

import Foundation

class Todo: Codable {
    private var items = [TodoItem]()

    var totalItems: Int {
        return items.count
    }

    func item(at index: Int) -> TodoItem {
        return items[index]
    }

    func add(item: TodoItem) {
        items.insert(item, at: 0)
    }

    func remove(at index: Int) {
        items.remove(at: index)
    }

    func index(of item: TodoItem) -> Int? {
        return items.firstIndex(where: { (todoItem) -> Bool in
            return todoItem === item
        })
    }

    func move(from sourceIndex: Int, to destinationIndex: Int) {
        let item = items.remove(at: sourceIndex)
        items.insert(item, at: destinationIndex)
    }
}

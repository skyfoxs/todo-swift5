//
//  TodoItem.swift
//  TodoApp
//
//  Created by Supakit Thanadittagorn on 20/5/19.
//  Copyright © 2019 pop. All rights reserved.
//

import Foundation

class TodoItem {
    var title: String
    var isDone: Bool

    init(title: String, isDone: Bool) {
        self.title = title
        self.isDone = isDone
    }
}

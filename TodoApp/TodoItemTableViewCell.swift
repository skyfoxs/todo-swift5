//
//  TodoItemTableViewCell.swift
//  TodoApp
//
//  Created by Supakit Thanadittagorn on 21/5/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?

    func configure(item: TodoItem) {
        titleLabel?.text = item.title
        checkboxButton?.setImage(UIImage(named: item.isDone ? "check": "uncheck"), for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

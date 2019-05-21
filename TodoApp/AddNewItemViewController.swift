//
//  AddNewItemViewController.swift
//  TodoApp
//
//  Created by Supakit Thanadittagorn on 20/5/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

protocol AddNewItemViewControllerDelegate: class {
    func addNewItemViewController(controller: AddNewItemViewController, didAdd item: TodoItem)
    func addNewItemViewController(controller: AddNewItemViewController, didEdit item: TodoItem)
    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController)
}

class AddNewItemViewController: UIViewController {

    weak var delegate: AddNewItemViewControllerDelegate?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!

    var todoItem: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let todoItem = todoItem {
            title = "Edit item"
            titleTextField.text = todoItem.title
            isDoneSwitch.setOn(todoItem.isDone, animated: true)
        } else {
            title = "Add new item"
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }
        if let todoItem = todoItem {
            todoItem.title = title
            todoItem.isDone = isDoneSwitch.isOn
            delegate?.addNewItemViewController(controller: self, didEdit: todoItem)
        } else {
            let todoItem = TodoItem(title: title, isDone: isDoneSwitch.isOn)
            delegate?.addNewItemViewController(controller: self, didAdd: todoItem)
        }
    }

    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewControllerDidCancel(controller: self)
    }
}

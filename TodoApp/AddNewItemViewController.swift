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
    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController)
}

class AddNewItemViewController: UIViewController {

    weak var delegate: AddNewItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewController(controller: self, didAdd: TodoItem(title: "Test"))
    }

    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewControllerDidCancel(controller: self)
    }
}

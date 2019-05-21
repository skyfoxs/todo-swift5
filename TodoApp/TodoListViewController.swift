//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by Supakit Thanadittagorn on 20/5/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ItemDetailViewControllerDelegate, TodoItemTableViewCellDelegate, UITableViewDragDelegate, UITableViewDropDelegate {

    @IBOutlet weak var tableView: UITableView?
    var todo = Todo()

    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.totalItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath) as! TodoItemTableViewCell
        let item = todo.item(at: indexPath.row)
        cell.configure(item: item, delegate: self)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todo.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openEditItemSegue", sender: todo.item(at: indexPath.row))
    }

    // MARK: - TableViewDragDelegate
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }

    // MARK: - TableViewDropDelegate
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {}

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.localDragSession != nil
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    // MARK: - ItemDetailViewControllerDelegate
    func itemDetailViewController(controller: ItemDetailViewController, didAdd item: TodoItem) {
        todo.add(item: item)
        if let index = todo.index(of: item) {
            tableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        controller.dismiss(animated: true, completion: nil)
    }

    func itemDetailViewController(controller: ItemDetailViewController, didEdit item: TodoItem) {
        if let index = todo.index(of: item) {
            tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        navigationController?.popViewController(animated: true)
    }

    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        if controller.isInEditMode {
            navigationController?.popViewController(animated: true)
        } else {
            controller.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - TodoItemTableViewCellDelegate
    func todoItemTableViewCellDidTapCheckboxButton(cell: TodoItemTableViewCell) {
        if let indexPath = tableView?.indexPath(for: cell) {
            todo.item(at: indexPath.row).isDone.toggle()
            tableView?.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Initial Page
    override func viewDidLoad() {
        super.viewDidLoad()
        todo.add(item: TodoItem(title: "Download XCode", isDone: true))
        todo.add(item: TodoItem(title: "Buy milk"))
        todo.add(item: TodoItem(title: "Learning Swift", isDone: false))

        tableView?.dragDelegate = self
        tableView?.dragInteractionEnabled = true

        tableView?.dropDelegate = self
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openAddItemSegue" {
            if let nav = segue.destination as? UINavigationController,
                let controller = nav.topViewController as? ItemDetailViewController {
                controller.delegate = self
            }
        } else if segue.identifier == "openEditItemSegue" {
            if let controller = segue.destination as? ItemDetailViewController {
                controller.todoItem = sender as? TodoItem
                controller.delegate = self
            }
        }
    }
}


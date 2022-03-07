//
//  ViewController.swift
//  coreTutorial
//
//  Created by Shikhar Sharma on 04/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!
    
    let coreDataInstance = CoreDataApplication()
    var todoItems = CoreDataApplication().getAllItems()

    func refreshTodoItems () {
        self.todoItems = self.coreDataInstance.getAllItems()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Core Data Todo App"
        tableView.delegate = self
        tableView.dataSource = self
        refreshTodoItems()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddDefault))
        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapAddDefault () {
        let alert = UIAlertController(title: "New Todo Item", message: "Enter new Todo", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self!.coreDataInstance.createItem(name: text, status: false)
            self!.refreshTodoItems()
        }))
        present(alert, animated: true)
    }


}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todoItem = todoItems[indexPath.row]
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
            coreDataInstance.deleteItem(todoItem: todoItem)
            self.refreshTodoItems()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteItem])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todoItem = todoItems[indexPath.row]
        let updateStatus = UIContextualAction(style: .normal, title: "Update Status") { [self] _, _Arg, _ in
            coreDataInstance.InvertItemStatus(todoItem: todoItem)
            print("update status button pressed")
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [updateStatus])
        return swipeConfiguration
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = todoItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(todoItem.name)"
        if (todoItem.status) {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .yellow
        }
        return cell
    }
    
    
}


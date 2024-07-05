//
//  TodoListViewController.swift
//  Lab6
//
//  Created by Naitik Ratilal Patel on 05/07/24.
//

import UIKit

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var todoListTableView: UITableView!
    @IBOutlet weak var sectionTextField: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var editSwitch: UISwitch!
    
    var todoItems: [TodoItem] = [item1, item2, item3, item4, item5, item6, item7, item8]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureSwitch()
    }
    
    private func setupView() {
        self.todoListTableView.delegate = self
        self.todoListTableView.dataSource = self
    }
    
    private func configureSwitch() {
        editSwitch.addTarget(self, action: #selector(switchOnOff), for: .valueChanged)
    }
    
    @objc func switchOnOff(_ sender: UISwitch) {
        todoListTableView.setEditing(sender.isOn, animated: true)
    }
    
    // clear form
    @IBAction func clearTodo() {
        self.sectionTextField.text = ""
        self.itemTextField.text = ""
    }
    
    // add new section and it's item
    @IBAction func addTodo() {
        if (sectionTextField.text == "" || itemTextField.text == "") {
            presentAlert(errorMessage: "Oops, seems fields are empty")
        } else {
            let todoItem = TodoItem(title: sectionTextField.text ?? "", items: [itemTextField.text ?? ""])
            self.todoItems.append(todoItem)
            
            DispatchQueue.main.async {
                self.todoListTableView.reloadData()
                self.sectionTextField.text = ""
                self.itemTextField.text = ""
            }
        }
    }
    
    // error alert
    private func presentAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alertController, animated: true)
    }
    
    // present alert that ask user to add todo item in existing section when user taps/select any of the row
    private func presentAlertToAddItem(section: Int) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: self.todoItems[section].title, message: "Please enter a todo item", preferredStyle: .alert)
            
            // adding text fields inside the alert
            alertController.addTextField { (textField) in
                textField.placeholder = "Enter todo item"
            }
            
            // alert action
            alertController.addAction(UIAlertAction(title: "Add", style: .cancel, handler: { _ in
                
                if let textFields = alertController.textFields {
                    let todoItem = textFields[0].text ?? ""
                    
                    // checking for empty fields
                    if (todoItem.isEmpty) {
                        self.presentAlert(errorMessage: "Oops, empty field passed.")
                    } else {
                        self.todoItems[section].items.append(todoItem)
                        DispatchQueue.main.async {
                            self.todoListTableView.reloadData()
                        }
                    }
                }
            }))
            
            self.present(alertController, animated: true)
        }
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // total number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return todoItems.count
    }
    
    // total rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return todoItems[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = todoItems[indexPath.section].items[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentAlertToAddItem(section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = todoItems[sourceIndexPath.section].items.remove(at: sourceIndexPath.row)
        todoItems[destinationIndexPath.section].items.insert(movedItem, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoItems[indexPath.section].items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            DispatchQueue.main.async { [self] in
                if todoItems[indexPath.section].items.isEmpty {
                    todoItems.remove(at: indexPath.section)
                    self.todoListTableView.reloadData()
                }
            }
        }
    }
}

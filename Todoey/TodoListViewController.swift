//
//  ViewController.swift
//  Todoey
//
//  Created by Niccolo Diana on 16/01/2019.
//  Copyright © 2019 Niccolo Diana. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    
    
    var itemArray = ["Find Mike", "Run Forrest", "Rocky Balboa"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "todoListArray") as? [String]{
            itemArray = items
        }
    }
    
    //MARK - Create Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add IB Action to Add items to the todo list
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Would you like to add an item to your todo list?", message: "", preferredStyle: .alert)
        
        let actionNewItem = UIAlertAction(title: "Add Item", style: .default) { (actionNewItem) in
            //what will happen after the user clicks the add item
            self.itemArray.append(textField.text ?? "Noname")
            
            self.defaults.setValue(self.itemArray, forKey: "todoListArray")
            self.tableView.reloadData()
        }
        
        let actionDismiss = UIAlertAction(title: "No, thanks", style: .default) { (actionDismiss) in
            print("Fail")
        }
        
        alert.addAction(actionNewItem)
        alert.addAction(actionDismiss)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
}


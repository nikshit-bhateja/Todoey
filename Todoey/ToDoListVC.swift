//
//  ViewController.swift
//  Todoey
//
//  Created by Nik Bhateja on 07/06/20.
//  Copyright © 2020 Nik Bhateja. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var ItemArray = [Item]()
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Find mike"
        ItemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        ItemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demegorgon"
        ItemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            ItemArray = items
        }
        
    }
    
    //MARK: - Table view datasource metheds
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for : indexPath)
        
        let item = ItemArray[indexPath.row]
        
        cell.textLabel!.text = item.title
        
        // Ternary operation ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("you choose \(ItemArray[indexPath.row]) Row")
        
        // To Highlighted row
        
        ItemArray[indexPath.row].done = !ItemArray[indexPath.row].done
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            let newItem = Item()
            newItem.title = textField.text!
            self.ItemArray.append(newItem)
            
            self.defaults.set(self.ItemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter item name"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}


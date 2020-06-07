//
//  ViewController.swift
//  Todoey
//
//  Created by Nik Bhateja on 07/06/20.
//  Copyright © 2020 Nik Bhateja. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var ItemArray = ["Find Mike","Buy Eggos","Destroy Demogoron"]
    
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let Items = defaults.array(forKey: "TodoListArray") as? [String] {
            
            ItemArray = Items
            
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
        
        cell.textLabel!.text = ItemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("you choose \(ItemArray[indexPath.row]) Row")
        
        // To Highlighted row
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
        // TO give checkmark to Row
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            self.ItemArray.append(textField.text! )
            
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


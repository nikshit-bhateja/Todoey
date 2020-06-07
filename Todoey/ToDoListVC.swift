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
    
    let dataPathFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        loadItems()
        
        
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
        
        saveItems()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            let newItem = Item()
            newItem.title = textField.text!
            self.ItemArray.append(newItem)
            
            self.saveItems()
            
            
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter item name"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(ItemArray)
            try data.write(to:dataPathFile!)
            
        } catch {
            print("Error encoding item array\(error)")
            
        }
        
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
     
        if let data = try? Data(contentsOf: dataPathFile!){
            
            let decoder = PropertyListDecoder()
            
            do {
            ItemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decode item array\(error)")
            }
            
        }
        
        
    }
    
}


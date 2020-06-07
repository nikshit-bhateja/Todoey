//
//  ViewController.swift
//  Todoey
//
//  Created by Nik Bhateja on 07/06/20.
//  Copyright © 2020 Nik Bhateja. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    let ItemArray = ["Find Mike","Buy Eggos","Destroy Demogoron"]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        // TO give checkmark to Row
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
    }
    

}


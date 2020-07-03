//  ViewController.swift
//  Todoey
//
//  Created by Allan Rosa on 08/06/2020.
//  Copyright © 2020 Allan Rosa. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var toDoItems: Results<TodoeyItem>?
    let realm = try! Realm()
    var selectedCategory: TodoeyCategory? {
		// didSet is a property observer that gets triggered after the variable's value was changed
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let colorHex = selectedCategory?.color {
            title = selectedCategory!.name
			
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
            }
			
            if let navBarColor = UIColor(hexString: colorHex) {
                navBar.backgroundColor = navBarColor
                navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                searchBar.barTintColor = navBarColor
            }
        }
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Let the cell be initialized from the superclass, so it'll be a SwipeTableCell
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
		
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(toDoItems!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            cell.accessoryType = item.isDone ? .checkmark : .none
        } else {
			cell.textLabel?.text = K.Content.Label.TodoListVC.emptyToDoList
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write{
					// Change the status of the tapped item
                    item.isDone = !item.isDone
                }
            } catch {
                print("Error saving item.isDone: \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // This textfield will hold our info
        var textField = UITextField()
		// Let's create an alert dialog to receive user input to our textfield
		let alert = UIAlertController(title: K.Content.Label.TodoListVC.addNew_title, message: "", preferredStyle: .alert)
		// This is how we'll handle the input
		let action = UIAlertAction(title: K.Content.Label.add, style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = TodoeyItem()
                        newItem.title = textField.text!
                        newItem.creationDate = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
		// Add the textfield we created earlier to grab that smexxy input
        alert.addTextField { (alertTextField) in
			alertTextField.placeholder = K.Content.Label.TodoListVC.addNew_placeholder
            textField = alertTextField
        }
		// Don't forget to add the action to the dialog!
        alert.addAction(action)

		// Present the alert we just created to the user
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods	
    func loadItems() {
		toDoItems = selectedCategory?.items.sorted(byKeyPath: K.App.Model.Item.creationDate, ascending: true)
        tableView.reloadData()
    }
    
	// Method from SwipeTableController which is triggered when the user swipes a cell to right
    override func updateModel(at indexPath: IndexPath) {
		// Since the action for swiping right is delete, let's delete the item
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
    }
	
}


//MARK: - SearchBar Delegate Methods
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		// [cd]: c: cAsE SeNsItIvE, d: dîäcrítìcs
		toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: K.App.Model.Item.title, ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
	
}

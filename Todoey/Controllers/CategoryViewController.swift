//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Allan Rosa on 09/06/2020.
//  Copyright © 2020 Allan Rosa. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories: Results<TodoeyCategory>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
		navBar.backgroundColor = UIColor(hexString: K.Design.Color.Primary.hex_brandBlue)
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
		cell.textLabel?.text = categories?[indexPath.row].name ?? K.Content.Label.CategoryVC.emptyCategoryList
        
        if let category = categories?[indexPath.row] {
            guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        return cell
    }
    
    
    //MARK: - Data Model Manipulation Methods
    func save(category: TodoeyCategory) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(TodoeyCategory.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
		let alert = UIAlertController(title: K.Content.Label.CategoryVC.addNew_title, message: "", preferredStyle: .alert)
		let action = UIAlertAction(title: K.Content.Label.add, style: .default) { (action) in
			// Create a new category
            let newCategory = TodoeyCategory()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
			// Save the category
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
			textField.placeholder = K.Content.Label.CategoryVC.addNew_placeholder
        }
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: K.App.View.segue_CategoryVC_TodoListVC, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
}


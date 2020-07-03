//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Allan Rosa on 10/06/2020.
//  Copyright © 2020 Allan Rosa. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
		let cell = tableView.dequeueReusableCell(withIdentifier: K.App.View.basicCellIdentifier, for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
		let deleteAction = SwipeAction(style: .destructive, title: K.Content.Label.delete) { action, indexPath in
            // Call the deletion method
            self.updateModel(at: indexPath)
            
        }
        
        // Customize the action appearance, let's add our trash icon
		deleteAction.image = UIImage(named: K.Design.Icon.deleteIcon)
        
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    
    func updateModel(at indexPath: IndexPath) {
        // Update our data model
    }
    
}

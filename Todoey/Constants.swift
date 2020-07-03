//
// Constants.swift
// Todoey
//
// Created by Allan Rosa on 30/06/20.
// Copyright © 2020 Allan Rosa. All rights reserved.
//

import UIKit

struct K {

	struct Design {
		struct Color {
			struct Primary {
				static let hex_brandBlue = "#1D9BF6"
			}
			struct Secondary {
				
			}
			struct Grayscale {
				
			}
			struct Alpha {
				
			}
		}
		struct Icon {
			static let deleteIcon = "delete-icon"
		}
	}
	
	struct App {
		struct Model {
			struct Category {
				static let name = "name"
				static let color = "color"
			}
			struct Item {
				static let title = "title"
				static let isDone = "isDone"
				static let creationDate = "creationDate"
			}
		}
		struct View {
			static let basicCellIdentifier = "Cell"
			static let segue_CategoryVC_TodoListVC = "goToItems"
		}
		
	}
	
	struct Content {
		struct Label {
			static let delete = "Delete"
			static let add = "Add"
			
			struct CategoryVC {
				static let addNew_title = "Add a new Todoey Category"
				static let addNew_placeholder = "Enter the category name"
				static let emptyCategoryList = "No categories added yet."
			}
			
			struct TodoListVC {
				static let addNew_title = "Add a new Todoey Item"
				static let addNew_placeholder = "Enter the item name"
				static let emptyToDoList = "No items added yet."
			}
		}
	}
}

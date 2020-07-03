//
//  Item.swift
//  Todoey
//
//  Created by Allan Rosa on 08/06/2020.
//  Copyright © 2020 Allan Rosa. All rights reserved.
//

import Foundation
import RealmSwift

class TodoeyItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var creationDate: Date?
    var parentCategory = LinkingObjects(fromType: TodoeyCategory.self, property: "items")
}

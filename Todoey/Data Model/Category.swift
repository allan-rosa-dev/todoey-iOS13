//
//  Category.swift
//  Todoey
//
//  Created by Allan Rosa on 09/06/2020.
//  Copyright © 2020 Allan Rosa. All rights reserved.
//

import Foundation
import RealmSwift

class TodoeyCategory: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<TodoeyItem>()
}

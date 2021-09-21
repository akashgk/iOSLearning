//
//  Category.swift
//  Todoey
//
//  Created by Akash G Krishnan on 21/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = "";
    let items = List<TodoItem>()
}

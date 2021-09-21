//
//  TodoItem.swift
//  Todoey
//
//  Created by Akash G Krishnan on 21/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var title : String = "";
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items" )
}

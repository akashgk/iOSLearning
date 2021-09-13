//
//  Item.swift
//  Todoey
//
//  Created by Akash G Krishnan on 12/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct Item : Codable {
    var title : String = ""
    var isComplete : Bool = false
}

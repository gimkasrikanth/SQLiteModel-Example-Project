//
//  Node.swift
//  tvOS+SQLiteModel
//
//  Created by Jeff Hurray on 4/24/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import Foundation
import SQLiteModel

struct Node: SQLiteModel {
    
    var localID: Int64 = -1
    
    static let Name = Expression<String>("name")
    static let Parent = Relationship<Node?>("parent")
    static let Children = Relationship<[Node]>("children")
    
    static func buildTable(tableBuilder: TableBuilder) {
        tableBuilder.column(Name)
        tableBuilder.relationship(Parent, mappedFrom: self)
        tableBuilder.relationship(Children, mappedFrom: self)
    }
}
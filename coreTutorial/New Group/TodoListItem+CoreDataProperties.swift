//
//  TodoListItem+CoreDataProperties.swift
//  coreTutorial
//
//  Created by Shikhar Sharma on 04/03/22.
//
//

import Foundation
import CoreData


extension TodoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListItem> {
        return NSFetchRequest<TodoListItem>(entityName: "TodoListItem")
    }

    @NSManaged public var name: String
    @NSManaged public var status: Bool
    @NSManaged public var createdAt : Date

}

extension TodoListItem : Identifiable {

}

//
//  coreDataApplication.swift
//  coreTutorial
//
//  Created by Shikhar Sharma on 04/03/22.
//

import Foundation
import UIKit

class CoreDataApplication {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveContext () -> Bool {
        do {
            try context.save()
            return true
        }
        catch {
            return false
        }
    }
    
    func getAllItems () -> [TodoListItem] {
        do {
            let items = try context.fetch(TodoListItem.fetchRequest())
            return items
        }
        catch {
            return []
        }
    }
    
    func createItem (name: String, status: Bool) -> Bool {
        let newItem = TodoListItem(context: context)
        newItem.name = name
        newItem.status = status
        newItem.createdAt = Date()
        return saveContext()
    }
    
    func updateItemName (todoItem: TodoListItem, newName: String) -> Bool{
        todoItem.name = newName
        return saveContext()
    }
    
    func InvertItemStatus (todoItem: TodoListItem) -> Bool{
        todoItem.status = !todoItem.status
        return saveContext()
    }
    
    func deleteItem (todoItem: TodoListItem) -> Bool {
        context.delete(todoItem)
        return saveContext()
    }
}

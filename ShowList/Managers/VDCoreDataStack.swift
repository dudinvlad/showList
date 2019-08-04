//
//  VDCoreDataStack.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import UIKit
import CoreData

class VDCoreDataStack: NSObject {
    
    static let coreDataStack = VDCoreDataStack()
    
    private override init() {
    }
    
    lazy var privateMoc: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        return context
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShowList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

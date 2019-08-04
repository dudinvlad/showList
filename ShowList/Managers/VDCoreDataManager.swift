//
//  VDCoreDataManager.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class VDCoreDataManager {
    
    static let shared = VDCoreDataManager()
    
    lazy var fetchedResultController : NSFetchedResultsController<NSFetchRequestResult> = {
        let context = VDCoreDataStack.coreDataStack.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.users)
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSortDescriptor]
       return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    func save(_ users: [VDUser]) {
        let context = VDCoreDataStack.coreDataStack.persistentContainer.viewContext
        let privateMoc = VDCoreDataStack.coreDataStack.privateMoc
        privateMoc.parent = context
        privateMoc.performAndWait {
            guard let entity = NSEntityDescription.entity(forEntityName: EntityNames.users, in: privateMoc) else {return}
            for user in users {
                let newUser = NSManagedObject(entity: entity, insertInto: privateMoc)
                newUser.setValue(user.name, forKey: "name")
                newUser.setValue(user.id, forKey: "id")
            }
            saveContext(privateMoc)
        }
        saveContext(context)
    }
    
    func update(_ person: User?, name: String?) {
        let context = VDCoreDataStack.coreDataStack.persistentContainer.viewContext
        let privateMoc = VDCoreDataStack.coreDataStack.privateMoc
        privateMoc.parent = context
        guard let id = person?.id else {return}
        privateMoc.performAndWait {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.users)
            fetchRequest.predicate = NSPredicate(format: "id = %@", id)
            do {
                let result = try privateMoc.fetch(fetchRequest) as? [User]
                if let user = result?.first {
                    user.setValue(name, forKey: "name")
                }
            } catch{}
            saveContext(privateMoc)
        }
        saveContext(context)
    }
    
//    func fetchUsers(completion: ([User]?) -> Void) {
//        let context = VDCoreDataStack.coreDataStack.persistentContainer.viewContext
//        let privateMoc = VDCoreDataStack.coreDataStack.privateMoc
//        privateMoc.parent = context
//        privateMoc.performAndWait {
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.users)
//            do {
//                 let data = try privateMoc.fetch(request) as? [User]
//                completion(data)
//            } catch {}
//        }
//    }
    
    //MARK: - Private
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait {
                do {
                    try context.save()
                } catch {}
            }
        }
    }
}

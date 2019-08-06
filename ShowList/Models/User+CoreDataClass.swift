//
//  User+CoreDataClass.swift
//  
//
//  Created by Влад Дудин on 8/3/19.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

}

extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var imageData: Data?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    
}

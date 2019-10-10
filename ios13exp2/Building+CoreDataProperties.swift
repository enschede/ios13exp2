//
//  Building+CoreDataProperties.swift
//  ios13exp2
//
//  Created by Marc Enschede on 30/09/2019.
//  Copyright © 2019 Marc Enschede. All rights reserved.
//
//

import Foundation
import CoreData


extension Building {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Building> {
        return NSFetchRequest<Building>(entityName: "Building")
    }

    @NSManaged public var name: String
    @NSManaged public var location: String
    @NSManaged public var favourite: Bool
    @NSManaged public var image: String
    
    convenience init(context: NSManagedObjectContext, name: String, location: String, favourite: Bool, image: String) {
        self.init(context: context)
        
        self.name = name
        self.location = location
        self.favourite = favourite
        self.image = image
    }
    
    convenience init(context: NSManagedObjectContext, name: String, location: String, image: String) {
        self.init(context: context)
        
        self.name = name
        self.location = location
        self.favourite = false
        self.image = image
    }

}

//
//  Albums+CoreDataProperties.swift
//  Albums_Swift
//
//  Created by Uday Kiran Ailapaka on 15/02/17.
//  Copyright © 2017 Uday Kiran Ailapaka. All rights reserved.
//

import Foundation
import CoreData


extension Albums {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Albums> {
        return NSFetchRequest<Albums>(entityName: "Albums");
    }

    @NSManaged public var albumId: NSNumber?
    @NSManaged public var albumTitle: String?
    @NSManaged public var userId: NSNumber?
    @NSManaged public var userName: String?
    @NSManaged public var photos: NSSet?
    @NSManaged public var user: Users?

}

// MARK: Generated accessors for photos
extension Albums {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photos)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photos)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

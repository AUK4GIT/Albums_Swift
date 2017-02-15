//
//  Photos+CoreDataProperties.swift
//  Albums_Swift
//
//  Created by Uday Kiran Ailapaka on 15/02/17.
//  Copyright © 2017 Uday Kiran Ailapaka. All rights reserved.
//

import Foundation
import CoreData


extension Photos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photos> {
        return NSFetchRequest<Photos>(entityName: "Photos");
    }

    @NSManaged public var albumId: NSNumber?
    @NSManaged public var photoId: NSNumber?
    @NSManaged public var photoThumbnailURL: String?
    @NSManaged public var photoURL: String?
    @NSManaged public var title: String?
    @NSManaged public var album: Albums?

}

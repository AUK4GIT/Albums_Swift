//
//  Users+CoreDataProperties.swift
//  Albums_Swift
//
//  Created by Uday Kiran Ailapaka on 15/02/17.
//  Copyright © 2017 Uday Kiran Ailapaka. All rights reserved.
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users");
    }

    @NSManaged public var name: String?
    @NSManaged public var userAddress: String?
    @NSManaged public var userCompany: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var userId: NSNumber?
    @NSManaged public var userName: String?
    @NSManaged public var userPhone: String?
    @NSManaged public var userWebSite: String?
    @NSManaged public var album: Albums?

}

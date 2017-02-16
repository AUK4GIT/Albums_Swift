//
//  Albums+CoreDataClass.swift
//  Albums_Swift
//
//  Created by Uday Kiran Ailapaka on 15/02/17.
//  Copyright © 2017 Uday Kiran Ailapaka. All rights reserved.
//

import Foundation
import CoreData


public class Albums: NSManagedObject {
    
    class func fetchAlbums(forContext context: NSManagedObjectContext)-> [Any] {
        let fetchRequest: NSFetchRequest<Albums> = Albums.fetchRequest()
        let sortDesc: NSSortDescriptor = NSSortDescriptor.init(key: "albumId", ascending: true);
        fetchRequest.sortDescriptors = [sortDesc];
        guard let results = try? context.fetch(fetchRequest) else {
            print("Error fetching Albums")
            //abort();
            return [];
        }
        return results ;
    }
    
    class func saveAlbums(albums: [Any], withUsers users: [Any], context: NSManagedObjectContext) {
        Albums.deleteEntityWithName(entityname: "Albums", context: context);
        Albums.deleteEntityWithName(entityname: "Users", context: context);
        Albums.deleteEntityWithName(entityname: "Photos", context: context);
        Albums.saveContext(context: context)
        
        for albumDict in albums {
            
            let albDict = albumDict as? [String : Any]
            
            let entity =  NSEntityDescription.entity(forEntityName: "Albums", in: context)
            let album = NSManagedObject(entity: entity!, insertInto: context) as? Albums

            let predicate: NSPredicate = NSPredicate.init(format: "id == %@", argumentArray: [albDict!["userId"] ?? ""]);
            let filteredArry: [Any] = (users as NSArray).filtered(using: predicate);
            
            if (filteredArry.count > 0) {
                album?.saveData(albumDict: albDict!, userDict: filteredArry[0] as! [String : Any], context: context)
            } else {
                album?.saveData(albumDict: albDict!, userDict: [:], context: context)
            }
        }
        Albums.saveContext(context: context)
    }
    
    func saveData(albumDict: [String: Any], userDict: [String: Any], context: NSManagedObjectContext) {
        
        if let obj = albumDict["id"] as? NSNumber {
            self.albumId = obj
        } else {
            let obj = albumDict["id"] as? String
            self.albumId = NSNumber.init(value: Int(obj!)!)
        }
        
        if let obj = albumDict["userId"] as? NSNumber {
            self.userId = obj
        } else {
            let obj = albumDict["userId"] as? String
            self.userId = NSNumber.init(value: Int(obj!)!)
        }
        
        if let obj = albumDict["title"] as? String {
            self.albumTitle = obj
        }

        if (userDict.keys.count > 0) {
            
            if let obj = userDict["username"] as? String {
                self.userName = obj
            }
            
            let entity =  NSEntityDescription.entity(forEntityName: "Users", in: context)
            let user = NSManagedObject(entity: entity!, insertInto: context) as? Users
            
            if let obj = albumDict["id"] as? NSNumber {
                user?.userId = obj
            } else {
                let obj = albumDict["id"] as? String
                user?.userId = NSNumber.init(value: Int(obj!)!)
            }
            
            if let obj = userDict["username"] as? String {
                user?.userName = obj
            }
            if let obj = userDict["name"] as? String {
                user?.name = obj
            }
            if let obj = userDict["email"] as? String {
                user?.userEmail = obj
            }
            if let obj = userDict["phone"] as? String {
                user?.userPhone = obj
            }
            if let obj = userDict["website"] as? String {
                user?.userWebSite = obj
            }
            
            self.setValue(user, forKey: "user");
        }
    }
    
    class func deleteEntityWithName(entityname: String, context: NSManagedObjectContext) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityname)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            let result = try context.execute(request)
            print(result)
        } catch {
            print(error.localizedDescription)
        }
    }

    class func saveContext(context: NSManagedObjectContext){
        do {
        try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

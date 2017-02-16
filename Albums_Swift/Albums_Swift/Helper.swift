//
//  Helper.swift
//  Albums_Swift
//
//  Created by Uday Kiran Ailapaka on 14/02/17.
//  Copyright © 2017 Uday Kiran Ailapaka. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Helper: NSObject {
    static let sharedInstance = Helper();
    let context: NSManagedObjectContext?
    
    override init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
    }
    
    func fetchAlbumsFromDB(completionBlock: ([Any]) -> ()) {
        completionBlock(Albums.fetchAlbums(forContext: context!));
    }
    
    func fetchAlbumsFromService(completionBlock: @escaping ([Any])->()) {
        
        guard let albumURL = URL.init(string: "http://jsonplaceholder.typicode.com/albums") else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: albumURL)
    
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            if (error == nil ) {
                do {
                    let albums = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
                
                        guard let usersURL = URL.init(string: "http://jsonplaceholder.typicode.com/users") else {
                            print("Error: cannot create URL")
                            return
                        }
                        let urlRequest = URLRequest(url: usersURL)
                        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
                            if error == nil {
                                do {
                                let users = try JSONSerialization.jsonObject(with: data!, options: []) as? [Any];
                                Albums.saveAlbums(albums: albums!, withUsers: users!, context: self.context!)
                                DispatchQueue.main.async(execute: {
                                    completionBlock(Albums.fetchAlbums(forContext: self.context!));
                                })
                                } catch let error as NSError{
                                    print(error)
                                }
                            } else {
                                print(error?.localizedDescription as Any)
                            }
                        });
                        task.resume();
                    
                } catch let error as NSError{
                    print(error)
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    task.resume();
    }
}

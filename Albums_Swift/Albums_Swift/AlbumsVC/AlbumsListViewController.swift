//
//  AlbumsListViewController.swift
//  Albums_Swift
//
//  Created by Uday Kiran Ailapaka on 14/02/17.
//  Copyright © 2017 Uday Kiran Ailapaka. All rights reserved.
//

import UIKit

class AlbumsListViewController: UITableViewController {
    var albums : [Any] = [];
    let helper = Helper.sharedInstance;
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Albums";
        self.tableView.rowHeight = 64;
        
        self.activityIndicator.tintColor = UIColor.darkGray;
        self.view.addSubview(self.activityIndicator);
        self.view.bringSubview(toFront: self.activityIndicator);
        self.activityIndicator.hidesWhenStopped = true;
        self.activityIndicator.center = self.view.center;
        
        // Initialize the refresh control.
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.backgroundColor = UIColor.lightGray;
        self.refreshControl?.tintColor = UIColor.white
        self.refreshControl?.addTarget(self, action: #selector(fetchAlbumsFromService), for: .valueChanged)
        self.fetchAlbumsFromDB()
    }
    
    func fetchAlbumsFromDB() {
        self.helper.fetchAlbumsFromDB { (dbAlbums) in
            if (dbAlbums.count > 0) {
                self.albums = dbAlbums;
                self.tableView.reloadData();
            } else {
                self.fetchAlbumsFromService()
            }
        }
    }
    
    func fetchAlbumsFromService() {
    
    self.activityIndicator.startAnimating()
        
        self.helper.fetchAlbumsFromService { (dbAlbums) in
            if (dbAlbums.count > 0) {
                self.albums = dbAlbums;
                self.tableView.reloadData()
            } else {
                //show Alert. No Albums found
            }
            self.refreshControl?.endRefreshing()
            self.activityIndicator.stopAnimating()

        }
        
    }
    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (segue.identifier == "Thumbnail") {
            let path:  IndexPath = self.tableView.indexPathForSelectedRow!;
            let album: Albums = self.albums[path.row] as! Albums;
            let destVC: ThumbnailsViewController = segue.destination as! ThumbnailsViewController;
//            destVC.album = album;
        }
        
    }
    
    // MARK: UITableViewDelegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.albums.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "AlbumList")! as UITableViewCell
        
        let album: Albums = self.albums[indexPath.row] as! Albums;
        cell.textLabel?.text = album.albumTitle;
        cell.detailTextLabel?.text = album.userName;
        
        return cell
    }


}

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
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView();
}

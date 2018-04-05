//
//  Loading.swift
//  chat
//
//  Created by Alexey Pichukov on 05.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

// Loading for ViewController
class LoadingViewController: UIViewController {
    
    fileprivate var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoadingViewController: LoadingShowable {
    
    func showLoading() {
        view.endEditing(false)
        loadingView = LoadingView()
        if let navigationView = navigationController?.view {
            loadingView!.show(onView: navigationView)
        } else {
            loadingView!.show(onView: view)
        }
    }
    
    func hideLoading() {
        loadingView?.hide()
        loadingView = nil
    }
}

// Loading for TableViewController
class LoadingTableViewController: UITableViewController {
    
    fileprivate var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoadingTableViewController: LoadingShowable {
    
    func showLoading() {
        tableView.endEditing(false)
        loadingView = LoadingView()
        if let navigationView = navigationController?.view {
            loadingView!.show(onView: navigationView)
        } else {
            loadingView!.show(onView: tableView)
        }
    }
    
    func hideLoading() {
        loadingView?.hide()
        loadingView = nil
    }
}

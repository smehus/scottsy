//
//  ViewController.swift
//  Scottsy
//
//  Created by Scott Mehus on 1/27/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import ScottsyKit
import UIKit

internal final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        viewModel.loadData()
            .producer.take(1)
            .startWithNext { [weak self] (valid) -> () in
                self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataCollection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = viewModel.dataCollection[indexPath.row]
        cell.textLabel!.text = item.title
        return cell
    }
}


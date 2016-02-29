//
//  ViewController.swift
//  Scottsy
//
//  Created by Scott Mehus on 1/27/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit
import Alamofire

struct APIConstants {
    static let baseURL = "https://openapi.etsy.com/v2/listings/active?api_key=5809yztwpe426srusbm3340g"
}

internal final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var dataCollection = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        Alamofire.request(.GET, APIConstants.baseURL).responseJSON { response in
            if let data = response.data {
                do {
                    let responseJson = try JSON(data: data)
                    let res = Response<[Item]>(json: responseJson)
                    if let collection = res.data {
                        self.dataCollection = collection
                        self.tableView.reloadData()
                    }
                } catch {
                    print("FAILURE TO DESERIALIZE")
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = dataCollection[indexPath.row]
        cell.textLabel!.text = item.title
        return cell
    }
}


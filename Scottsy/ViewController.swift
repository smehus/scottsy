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

class ViewController: UIViewController {

    @IBOutlet weak var serachField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, APIConstants.baseURL).responseJSON { response in
            if let data = response.data {
                do {
                    let responseJson = try JSON(data: data)
                    let res = Response<[Item]>(json: responseJson)
                } catch {
                    print("FAILURE TO DESERIALIZE")
                }
            }
        }
    }
    
    private func searchWithText(text: String) {
        
    }


    @IBAction func searchPressed(sender: AnyObject) {
        
        
    }
}


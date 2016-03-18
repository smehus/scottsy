//
//  Response.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/12/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

public class Response<T where T: JSONSerializable> {
    
    private(set) var data: T?
    private(set) var error: ResponseError?
    
    public required init(json: JSON, error: NSError?) {
        
        if let _: Int = json.valueForKey("count"),
            _: RawJSON = json.valueForKey("pagination"),
            results: JSON = json.jsonValueFor("results") {

                do {
                    data = try T(json: results)
                } catch {
                    
                }
        }
    }
}

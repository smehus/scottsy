//
//  Array+JSONSerializable.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/26/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import ScottsyKit
import Foundation

extension Array: JSONSerializable {
    
    public init(json: JSON) throws {
        
        guard let ElementType = Element.self as? JSONSerializable.Type else {
            throw ScottsError.JSONFail
        }
        
        var objects = [Element]()
        for jsonObject in json {
            // Filling each object in the array
            guard let object = try ElementType.init(json: jsonObject) as? Element else {
                throw ScottsError.JSONFail
            }
            
            objects.append(object)
        }
        
        self.init(objects)
    }
    
    func toJSON() -> JSON? {
        return nil
    }
}
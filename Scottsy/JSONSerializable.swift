//
//  JSONSerializable.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/12/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

internal protocol JSONSerializable {
    
    init(json: JSON) throws
}

//
//  JSONTransformer.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal protocol JSONTransformer {
    
    typealias TransformType
    
    func transform(rawType: AnyObject) -> TransformType
}

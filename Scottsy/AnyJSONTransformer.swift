//
//  AnyJSONTransformer.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

internal struct AnyJSONTransformer<T>: JSONTransformer {
    
    typealias TransformType = T?
    
    let transformer: AnyObject -> TransformType
    
    func transform(rawType: AnyObject) -> TransformType {
     
        return self.transformer(rawType)
    }
}

internal func jsonTransformer<T>(transform: AnyObject -> T?) -> AnyJSONTransformer<T> {
    
    return AnyJSONTransformer(transformer: transform)
}
//
//  AnyJSONTransformer.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

public struct AnyJSONTransformer<T>: JSONTransformer {
    
    public typealias TransformType = T?
    
    public let transformer: AnyObject -> TransformType
    
    public init(transformer: AnyObject -> T?) {
        self.transformer = transformer
    }
    
    public func transform(rawType: AnyObject) -> TransformType {
     
        return self.transformer(rawType)
    }
}

public func jsonTransformer<T>(transform: AnyObject -> T?) -> AnyJSONTransformer<T> {
    
    return AnyJSONTransformer(transformer: transform)
}
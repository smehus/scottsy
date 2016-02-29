//
//  JSON.swift
//  Scottsy
//
//  Created by Scott Mehus on 1/27/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal typealias RawJSON = [String: AnyObject]

internal enum ScottsError: ErrorType {
    case JSONFail
    case JSONNotString
}

internal struct JSON {
    
    typealias Generator = AnyGenerator<JSON>
    
    private var data: AnyObject?
    
    init(data: NSData) throws {
        
        var json: AnyObject
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            self.data = json
        } catch {
            print("JSON FAILE")
            throw ScottsError.JSONFail
        }
    }
    
    init(object: AnyObject) throws {
         
        do {
            if let stringValue = object as? String, data = stringValue.dataUsingEncoding(NSUTF8StringEncoding)  {
                self.data = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } else {
                self.data = object
            }
            
        } catch {
            throw ScottsError.JSONFail
        }

    }
    
    private var internalDictionary: RawJSON {
        guard let object = data else {
            fatalError()
        }
        
        return object as! RawJSON
    }
    
    private var internalArray: [RawJSON]? {
        return data as? [RawJSON]
    }
    
    func valueForKey<T>(key: String) -> T? {
        let rawValue = internalDictionary[key] ?? RawJSON()
        if let obj = rawValue as? T {
            
            return obj
        }
        
        print("ERROR KEY VALUE \(key) \(T.self)")
        return nil
    }
    
    func jsonValueFor(key: String) -> JSON? {
        return self.valueFor(key, transformer: jsonTransformer({ (value) -> JSON? in
            do {
                return try JSON(object: value)
            } catch {
                print("ERRRROR \(error)")
                return nil
            }
        }))
    }
    

    func valueFor<U: JSONTransformer>(key: String, transformer: U) -> U.TransformType {
        let rawValue = internalDictionary[key] ?? RawJSON()
        return transformer.transform(rawValue)
    }
}

extension JSON: SequenceType {
    
    func generate() -> Generator {
        var index = 0
        return anyGenerator({ () -> JSON? in
            guard let arr = self.internalArray else {
                return nil
            }
            if index < arr.count {
                let t = arr[index++]
                do {
                    return try JSON(object: t)
                } catch {
                    print("SEQUENCE TYPE ERROR")
                    return nil
                }
                
            }
            
            return nil
        })
    }
}





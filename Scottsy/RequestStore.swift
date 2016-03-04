//
//  RequestStore.swift
//  Scottsy
//
//  Created by Scott Mehus on 3/4/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Alamofire

internal struct APIConstants {
    static let baseURL = "https://openapi.etsy.com/v2/"
    static let Active = "\(baseURL)\("listings/active")"
    static let Categories = "\(baseURL)\("taxonomy/categories")"
}

internal final class RequestStore<T where T: JSONSerializable> {
    
    static func requestForCategories() {
        
        Alamofire.request(.GET, APIConstants.Categories, parameters: nil).response {request, response, data, error in
            
        }
    }
    
    static func requestWithSearch(search: String) -> SignalProducer<T, ResponseError> {
        return SignalProducer<T, ResponseError>({ (observer, _) in
            
            let params = ["limit" : "20",
                            "offset": "0",
                            "includes": "Images:1",
                            "keywords": "shirt",
                            "api_key": "5809yztwpe426srusbm3340g"]
            
            Alamofire.request(.GET, APIConstants.Active, parameters: params)
                .response { request, response, data, error in
                    
                    guard let responseData = data else {
                        observer.sendFailed(ResponseError())
                        return
                    }

                    do {
                        let responseJSON = try JSON(data: responseData)
                        let res = Response<T>(json: responseJSON, error: error)
                        if let items = res.data {
                            observer.sendNext(items)
                        } else if let error = res.error {
                            observer.sendFailed(error)
                        }
                        
                        observer.sendCompleted()
                    } catch {
                        observer.sendFailed(ResponseError())
                        observer.sendCompleted()
                    }
            }
        })
    }
}

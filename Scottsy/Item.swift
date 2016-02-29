//
//  Item.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/12/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

internal struct Item: JSONSerializable {
    
    let category_id: Int
    let description: String
    let listing_id: Int
    let price: String
    let title: String
    let url: String
    
    init(json: JSON) throws {
        
        guard let desc: String = json.valueForKey("description"),
        catId: Int = json.valueForKey("category_id"),
        listID: Int = json.valueForKey("listing_id"),
        pr: String = json.valueForKey("price"),
        tits: String = json.valueForKey("title"),
        urlString: String = json.valueForKey("url")
        else {
            throw ScottsError.JSONFail
        }
        
        self.category_id = catId
        self.description = desc
        self.listing_id = listID
        self.price = pr
        self.title = tits
        self.url = urlString
    }
    
}
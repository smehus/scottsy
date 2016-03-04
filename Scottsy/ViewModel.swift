//
//  ViewModel.swift
//  Scottsy
//
//  Created by Scott Mehus on 2/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Alamofire

internal final class ViewModel {
    
    var dataCollection = [Item]()
    
    func loadData() -> SignalProducer<(), ScottsError> {
        return SignalProducer<(), ScottsError>({ (observer, _) in
            RequestStore<[Item]>.requestWithSearch("").on(next: { [weak self] res in
                
                self?.dataCollection = res
                observer.sendNext()
                observer.sendCompleted()
                
                }, failed: { error in
                    
                    observer.sendFailed(ScottsError.APIFAiled)
                    
            }).start()
        })
    }
    
}

//
//  ExchangeRate.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

public struct ExchangeRate {
    
    public let identifier: String
    public let name: String
    public let rate: NSDecimalNumber
    
}

public extension ExchangeRate {
    
    public static func fetch(pair : String) -> Request {
        return self.fetch([pair])
    }
    
    public static func fetch(pair : [String]) -> Request {
        return Alamofire.request(Router.ExchangeRates.Fetch(pair))
    }
    
}

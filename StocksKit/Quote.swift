//
//  Quote.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

public struct Quote {
    
    public var symbol : String
    public var name : String
    public var currency : String
    public var exchange : String
    public var lastTradePrice : NSDecimalNumber
   
    public init(symbol: String, name: String, exchange: String, currency: String, lastTradePrice: NSDecimalNumber) {
        self.symbol = symbol
        self.name = name
        self.exchange = exchange
        self.currency = currency
        self.lastTradePrice = lastTradePrice
    }
    
    
}

public extension Quote {
    
    public static func fetch(symbol : String) -> Request {
        return self.fetch([symbol])
    }
    
    public static func fetch(symbols : [String]) -> Request {
        return Alamofire.request(Router.Quotes.Fetch(symbols))
    }
    
}

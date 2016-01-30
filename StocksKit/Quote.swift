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
    
    public let symbol : String
    public let name : String
    public let currency : String
    public let exchange : String
    public let lastTradePrice : NSDecimalNumber
    public let change : NSDecimalNumber
    public let percentChange : NSDecimalNumber
    
    public init(symbol: String, name: String, exchange: String, currency: String, lastTradePrice: NSDecimalNumber, change: NSDecimalNumber, percentChange: NSDecimalNumber) {
        self.symbol = symbol
        self.name = name
        self.exchange = exchange
        self.currency = currency
        self.lastTradePrice = lastTradePrice
        self.change = change
        self.percentChange = percentChange
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

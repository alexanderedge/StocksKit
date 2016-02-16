//
//  Quote.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public struct Quote : QuoteType {
    
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
    
    public static func fetch(symbol : String, completionHandler: Result<[Quote], NSError> -> Void) -> NSURLSessionDataTask {
        return self.fetch([symbol], completionHandler: completionHandler)
    }
    
    public static func fetch(symbols : [String], completionHandler: Result<[Quote], NSError> -> Void) -> NSURLSessionDataTask {
        return NSURLSession.sharedSession().dataTaskWithRequest(Router.Quotes.Fetch(symbols).URLRequest, completionHandler: completionHandler)
    }
    
}

extension NSURLSession {
    
    public func dataTaskWithRequest(request: NSURLRequest, completionHandler: Result<[Quote], NSError> -> Void) -> NSURLSessionDataTask {
        return dataTaskWithRequest(request, responseSerializer: QuoteResponseSerializer.serializer(), completionHandler: completionHandler)
    }
    
}
extension CollectionType where Generator.Element: QuoteType {
    
    public var currencies: [String] {
        return Array(Set(self.map({$0.currency})))
    }
    
}


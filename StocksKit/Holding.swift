//
//  Holding.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

public protocol TransactionType {
    
    var symbol: String {get}
    var units: Int {get}
    var price: NSDecimalNumber {get}
    var currency: String {get}
}

public struct StockPurchase : TransactionType {
    
    public var symbol: String
    public var units: Int
    public var price: NSDecimalNumber
    public var currency: String
    
    public init(symbol: String, units: Int, price: NSDecimalNumber, currency: String = "GBp") {
        self.symbol = symbol
        self.units = units
        self.price = price
        self.currency = currency
    }
    
}

extension StockPurchase {
    
    public func value(quote: Quote) -> NSDecimalNumber {
        return quote.lastTradePrice * NSDecimalNumber(integer: self.units)
    }
    
    public func gain(quote: Quote) -> NSDecimalNumber{
        return self.value(quote) - self.price
    }
    
}

extension CollectionType where Generator.Element: TransactionType {
    
    public func fetchQuotes(completionHandler: Alamofire.Response<[Quote],NSError> -> Void) -> Request {
        return Quote.fetch(self.map({$0.symbol})).responseQuotes(completionHandler)
    }
    
}


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
    var shares: Int {get}
    var price: NSDecimalNumber {get}
    var commission: NSDecimalNumber {get}
    
}

public struct StockPurchase : TransactionType {
    
    public let symbol: String
    public let shares: Int
    public let price: NSDecimalNumber
    public let commission: NSDecimalNumber
    
    public init(symbol: String, shares: Int, price: NSDecimalNumber, commission: NSDecimalNumber) {
        self.symbol = symbol
        self.shares = shares
        self.price = price
        self.commission = commission
    }
    
}

public func == (lhs: StockPurchase, rhs: StockPurchase) -> Bool {
    return lhs.symbol == rhs.symbol && lhs.shares == rhs.shares && lhs.price == rhs.price && lhs.commission == rhs.commission
}

extension StockPurchase: Hashable {
    
    public var hashValue: Int {
        return self.symbol.hashValue
    }
    
}

extension TransactionType {
    
    public func value(quote: Quote) -> NSDecimalNumber {
        return quote.lastTradePrice * NSDecimalNumber(integer: self.shares)
    }
    
    public func gain(quote: Quote) -> NSDecimalNumber {
        return (self.value(quote) - NSDecimalNumber(integer: self.shares) * self.price)
    }
    
}

extension CollectionType where Generator.Element: TransactionType {
    
    public var numberOfShares: Int {
        return self.reduce(0){$0 + $1.shares}
    }
    
    public var averagePrice: NSDecimalNumber {
        return self.cost / NSDecimalNumber(integer: self.numberOfShares)
    }
    
    public var cost: NSDecimalNumber {
        return self.reduce(0){$0 + $1.price * NSDecimalNumber(integer: $1.shares)}
    }
    
    public func marketValue(quote: Quote) -> NSDecimalNumber {
        return self.reduce(0){$0 + $1.value(quote)}
    }
    
    public func totalGain(quote: Quote) -> NSDecimalNumber {
        return self.marketValue(quote) - self.cost
    }
    
    public func totalPercentGain(quote: Quote) -> NSDecimalNumber {
        return self.totalGain(quote) / self.cost
    }
    
    public func fetchQuotes(completionHandler: Alamofire.Response<[Quote],NSError> -> Void) -> Request {
        return Quote.fetch(self.map({$0.symbol})).responseQuotes(completionHandler)
    }
    
}


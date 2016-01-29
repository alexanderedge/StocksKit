//
//  Holding.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

public protocol HoldingType {
    
    var symbol: String {get}
    var shares: NSDecimalNumber {get}
    var price: NSDecimalNumber {get}
    var commission: NSDecimalNumber {get}
    var exchangeRate: NSDecimalNumber {get}
    
}

public struct Holding : HoldingType {
    
    public let symbol: String
    public let shares: NSDecimalNumber
    public let price: NSDecimalNumber
    public let exchangeRate: NSDecimalNumber
    public let commission: NSDecimalNumber
    
    public init(symbol: String, shares: NSDecimalNumber, price: NSDecimalNumber, exchangeRate: NSDecimalNumber = 1, commission: NSDecimalNumber) {
        self.symbol = symbol
        self.shares = shares
        self.price = price
        self.exchangeRate = exchangeRate
        self.commission = commission
    }
    
}

public func == (lhs: Holding, rhs: Holding) -> Bool {
    return lhs.symbol == rhs.symbol && lhs.shares == rhs.shares && lhs.price == rhs.price && lhs.commission == rhs.commission
}

extension Holding: Hashable {
    
    public var hashValue: Int {
        return self.symbol.hashValue
    }
    
}

extension HoldingType {
    
    public var cost: NSDecimalNumber {
        return self.shares * self.price * self.exchangeRate + self.commission
    }
    
    public func value(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber {
        return quote.lastTradePrice * self.shares * exchangeRate
    }
    
    public func gain(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber {
        return (self.value(quote, exchangeRate: exchangeRate) - self.cost)
    }
    
}

extension CollectionType where Generator.Element: HoldingType {
    
    public var numberOfShares: NSDecimalNumber {
        return self.reduce(0){$0 + $1.shares}
    }
    
    public var averagePrice: NSDecimalNumber {
        return self.cost / self.numberOfShares
    }
    
    public var cost: NSDecimalNumber {
        return self.reduce(0){$0 + $1.cost}
    }
    
    public func value(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber {
        return self.reduce(0){$0 + $1.value(quote, exchangeRate: exchangeRate)}
    }
    
    public func gain(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber {
        return self.value(quote, exchangeRate: exchangeRate) - self.cost
    }
    
}


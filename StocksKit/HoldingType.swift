//
//  HoldingType.swift
//  StocksKit
//
//  Created by Alexander Edge on 31/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public protocol HoldingType {
    
    var UUID: NSUUID { get }
    var symbol: String { get }
    var shares: NSDecimalNumber { get }
    var price: NSDecimalNumber { get }
    var exchangeRate: NSDecimalNumber { get }
    var commission: NSDecimalNumber { get }
    
}

extension HoldingType {
    
    public var cost: NSDecimalNumber {
        return self.shares * self.price * self.exchangeRate + self.commission
    }
    
    public func value(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber {
        precondition(quote.symbol == symbol, "Quote must be for the same symbol")
        return quote.lastTradePrice * self.shares * exchangeRate
    }
    
    public func gain(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber {
        return (self.value(quote, exchangeRate: exchangeRate) - self.cost)
    }
    
}

extension CollectionType where Generator.Element: HoldingType {
    
    public var symbols: [String] {
        return Array(Set(self.map({$0.symbol})))
    }
    
    public var cost: NSDecimalNumber {
        return self.reduce(0) {$0 + $1.cost}
    }
    
}
//
//  HoldingType.swift
//  StocksKit
//
//  Created by Alexander Edge on 31/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public protocol HoldingType {
    
    var symbol: String { get }
    var shares: NSDecimalNumber { get }
    var cost: NSDecimalNumber { get }
    func value(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber
    func gain(quote: Quote, exchangeRate: NSDecimalNumber) -> NSDecimalNumber
    
}

extension HoldingType {
    
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
    
    public var shares: NSDecimalNumber {
        return self.reduce(0) {$0 + $1.shares}
    }
    
}
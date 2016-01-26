//
//  Order.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public func * (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

public func / (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}

public func + (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

public func - (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberBySubtracting(right)
}

public struct Order {
    
    public var symbol : String
    public var quantity : NSDecimalNumber
    public var price : NSDecimalNumber
    public var currency : String
    
    public var baseCurrency : String
    
    public var commission : NSDecimalNumber
    
    public init(symbol: String, quantity: NSDecimalNumber, price: NSDecimalNumber, currency: String, baseCurrency: String, commission: NSDecimalNumber) {
        self.symbol = symbol
        self.quantity = quantity
        self.price  = price
        self.currency  = currency
        self.baseCurrency = baseCurrency
        self.commission  = commission
    }
    
    
    
}

extension Order {
    
    public enum OrderError : ErrorType {
        case IncompatibleSymbol
        case IncompatibleCurrency
    }
    
    public var cost : NSDecimalNumber {
        return self.price * self.quantity + self.commission
    }
    
    public func currentValue(quote : Quote) throws -> NSDecimalNumber {
        guard self.symbol == quote.symbol else {
            throw OrderError.IncompatibleSymbol
        }
        guard self.currency == quote.currency else {
            throw OrderError.IncompatibleCurrency
        }
        return quote.lastTradePrice * self.quantity
    }
    
    public func gain(quote : Quote) throws -> NSDecimalNumber {
        return try self.currentValue(quote) - self.cost
    }
    
}

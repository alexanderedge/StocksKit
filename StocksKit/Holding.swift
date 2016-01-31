//
//  Holding.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

final public class Holding: NSObject, NSCoding {
    
    public let UUID: NSUUID
    public let symbol: String
    public let shares: NSDecimalNumber
    public let price: NSDecimalNumber
    public let exchangeRate: NSDecimalNumber
    public let commission: NSDecimalNumber
    
    public init(symbol: String, shares: NSDecimalNumber, price: NSDecimalNumber, exchangeRate: NSDecimalNumber = 1, commission: NSDecimalNumber) {
        self.UUID = NSUUID()
        self.symbol = symbol
        self.shares = shares
        self.price = price
        self.exchangeRate = exchangeRate
        self.commission = commission
    }
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if let item = object as? Holding {
            return UUID == item.UUID
        }
        return false
    }
    
    private enum SerializationKeys : String {
        case UUID = "uuid"
        case Symbol = "symbol"
        case Shares = "shares"
        case Price = "price"
        case ExchangeRate = "exchangeRate"
        case Commission = "commission"
    }
    
    public required init(coder aDecoder: NSCoder) {
        UUID = aDecoder.decodeObjectForKey(SerializationKeys.UUID.rawValue) as! NSUUID
        symbol = aDecoder.decodeObjectForKey(SerializationKeys.Symbol.rawValue) as! String
        shares = aDecoder.decodeObjectForKey(SerializationKeys.Shares.rawValue) as! NSDecimalNumber
        price = aDecoder.decodeObjectForKey(SerializationKeys.Price.rawValue) as! NSDecimalNumber
        exchangeRate = aDecoder.decodeObjectForKey(SerializationKeys.ExchangeRate.rawValue) as! NSDecimalNumber
        commission = aDecoder.decodeObjectForKey(SerializationKeys.Commission.rawValue) as! NSDecimalNumber
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.UUID, forKey: SerializationKeys.UUID.rawValue)
        aCoder.encodeObject(self.symbol, forKey: SerializationKeys.Symbol.rawValue)
        aCoder.encodeObject(self.shares, forKey: SerializationKeys.Shares.rawValue)
        aCoder.encodeObject(self.price, forKey: SerializationKeys.Price.rawValue)
        aCoder.encodeObject(self.exchangeRate, forKey: SerializationKeys.ExchangeRate.rawValue)
        aCoder.encodeObject(self.commission, forKey: SerializationKeys.Commission.rawValue)
    }
    
}

extension Holding {
    
    enum HoldingError: ErrorType {
        case IncompatibleSymbol
    }
    
    public var cost: NSDecimalNumber {
        return self.shares * self.price * self.exchangeRate + self.commission
    }
    
    public func value(quote: Quote, exchangeRate: NSDecimalNumber) throws -> NSDecimalNumber {
        guard quote.symbol == self.symbol else { throw HoldingError.IncompatibleSymbol }
        return quote.lastTradePrice * self.shares * exchangeRate
    }
    
    public func gain(quote: Quote, exchangeRate: NSDecimalNumber) throws -> NSDecimalNumber {
        return (try self.value(quote, exchangeRate: exchangeRate) - self.cost)
    }
    
}

extension CollectionType where Generator.Element: Holding {
    
    public var symbols: [String] {
        return Array(Set(self.map({$0.symbol})))
    }
    
}


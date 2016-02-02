//
//  Holding.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

final public class Holding: NSObject, HoldingType, NSCoding {
    
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

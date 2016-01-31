//
//  Portfolio.swift
//  StocksKit
//
//  Created by Alexander Edge on 29/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

final public class Portfolio: NSObject, NSCoding {
    
    public var holdings: [Holding]
    public var currency: String
    
    public init(holdings: [Holding] = [], currency: String) {
        self.holdings = holdings
        self.currency = currency
    }
    
    private enum SerializationKeys : String {
        case Holdings = "holdings"
        case Currency = "currency"
    }
    
    public required init(coder aDecoder: NSCoder) {
        holdings = aDecoder.decodeObjectForKey(SerializationKeys.Holdings.rawValue) as! [Holding]
        currency = aDecoder.decodeObjectForKey(SerializationKeys.Currency.rawValue) as! String
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.holdings, forKey: SerializationKeys.Holdings.rawValue)
        aCoder.encodeObject(self.currency, forKey: SerializationKeys.Currency.rawValue)
    }
    
}

extension Portfolio {
    
    public var cost: NSDecimalNumber {
        return holdings.reduce(0){$0 + $1.cost}
    }
    
}
//
//  AggregateHolding.swift
//  StocksKit
//
//  Created by Alexander Edge on 15/02/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public class AggregateHolding: HoldingType {
    
    public var symbol: String
    private var holdings: [Holding]
    
    public init(symbol: String, holdings: [Holding]) {
        
        // they should all be the same symbol
        self.symbol = symbol
        self.holdings = holdings
    }
       
    public var shares: NSDecimalNumber {
        return holdings.shares
    }
    
    public var cost: NSDecimalNumber {
        return holdings.cost
    }
    
}

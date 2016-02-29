//
//  QuoteType.swift
//  StocksKit
//
//  Created by Alexander Edge on 31/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public protocol QuoteType {
    
    var symbol: String { get }
    var name : String { get }
    var currency : String { get }
    var exchange : String { get }
    var lastTradePrice : NSDecimalNumber { get }
    var change : NSDecimalNumber { get }
    var percentChange : NSDecimalNumber { get }
    
}
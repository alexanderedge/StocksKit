//
//  Portfolio.swift
//  StocksKit
//
//  Created by Alexander Edge on 29/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

final public class Portfolio: NSObject, NSCoding {
    
    enum PortfolioError : ErrorType {
        case MissingQuote
    }
    
    public var holdings: [Holding]
    public var currency: String
    
    private let exchangeRates: [String: NSDecimalNumber] = ["USD" : 0.696758, "GBp": 0.01, "GBP": 1]
    private let quotes: [String: Quote] = [:]
    
    public init(holdings: [Holding], currency: String) {
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
    
    private func verifyQuotesForHoldings(quotes: [Quote], holdings: [Holding]) throws {
        guard Set(holdings.map({$0.symbol})).isSubsetOf(Set(quotes.map({$0.symbol}))) else {
            throw PortfolioError.MissingQuote
        }
    }   
    
}

extension Portfolio {
    
    public var cost: NSDecimalNumber {
        return holdings.reduce(0){$0 + $1.cost}
    }
    
    public var symbols: [String] {
        return Array(Set(holdings.map({$0.symbol})))
    }
    
    public func gain(quotes: [Quote]) throws -> NSDecimalNumber {
        try verifyQuotesForHoldings(quotes, holdings: holdings)
        return quotes.reduce(0) {
            let quote = $1
            let holdings: [Holding] = self.holdings.filter({$0.symbol == quote.symbol})
            if let exchangeRate = exchangeRates[quote.currency] {
                return $0 + holdings.reduce(0){
                    do {
                        return try $1.value(quote, exchangeRate: exchangeRate) + $0
                    } catch {
                        return $0
                    }} - holdings.reduce(0){$0 + $1.cost}
            } else {
                return $0
            }
        }
    }
    
    public func value(quotes: [Quote]) throws -> NSDecimalNumber {
        try verifyQuotesForHoldings(quotes,holdings: holdings)
        return quotes.reduce(0) {
            let quote = $1
            let holdings: [Holding] = self.holdings.filter({$0.symbol == quote.symbol})
            if let exchangeRate = exchangeRates[quote.currency] {
                return $0 + holdings.reduce(0){
                    do {
                        return try $1.value(quote, exchangeRate: exchangeRate) + $0
                    } catch {
                        return $0
                    }
                }
            } else {
                return $0
            }
        }
    }
    
}
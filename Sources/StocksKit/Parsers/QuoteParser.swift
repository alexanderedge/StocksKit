//
//  QuoteParser.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

private struct PercentNumberFormatter {
    
    private static let formatter : NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .PercentStyle
        formatter.generatesDecimalNumbers = true
        formatter.positivePrefix = "+"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return formatter
    }()
    
    static func numberFromString(string : String) -> NSDecimalNumber? {
        return formatter.numberFromString(string) as? NSDecimalNumber
    }
    
}

internal struct QuoteParser : JSONParsingType {
    
    typealias T = Quote
    
    enum QuoteError : ErrorType {
        case MissingOrInvalidSymbol
        case MissingOrInvalidName
        case MissingOrInvalidStockExchange
        case MissingOrInvalidCurrency
        case MissingOrInvalidAskPrice
        case MissingOrInvalidBidPrice
        case MissingOrInvalidLastTradePrice
        case MissingOrInvalidChange
        case MissingOrInvalidPercentChange
    }
    
    static func parse(json: [String : AnyObject]) throws -> T {
    
        guard let symbol = json["symbol"] as? String else {
            throw QuoteError.MissingOrInvalidName
        }
        
        guard let name = json["Name"] as? String else {
            throw QuoteError.MissingOrInvalidName
        }
        
        guard let exchange = json["StockExchange"] as? String else {
            throw QuoteError.MissingOrInvalidStockExchange
        }
        
        guard let currency = json["Currency"] as? String else {
            throw QuoteError.MissingOrInvalidCurrency
        }
        
        guard let lastTradePrice = json["LastTradePriceOnly"] as? String else {
            throw QuoteError.MissingOrInvalidLastTradePrice
        }
        
        guard let change = json["Change"] as? String else {
            throw QuoteError.MissingOrInvalidChange
        }
        
        guard let percentChangeString = json["ChangeinPercent"] as? String, let percentChange = PercentNumberFormatter.numberFromString(percentChangeString) else {
            throw QuoteError.MissingOrInvalidPercentChange
        }
        
        return Quote(symbol: symbol, name: name, exchange: exchange, currency: currency, lastTradePrice: NSDecimalNumber(string: lastTradePrice), change: NSDecimalNumber(string: change), percentChange: percentChange)

    }
   
}

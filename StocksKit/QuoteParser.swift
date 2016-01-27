//
//  QuoteParser.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

struct QuoteParser : JSONParsingType {
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
    
    func parse(json: [String : AnyObject]) throws -> T {
    
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
        
        guard let percentChange = json["ChangeinPercent"] as? String else {
            throw QuoteError.MissingOrInvalidPercentChange
        }
        
        let percentChangeNumber = NSDecimalNumber(string: percentChange)
        return Quote(symbol: symbol, name: name, exchange: exchange, currency: currency, lastTradePrice: NSDecimalNumber(string: lastTradePrice), change: NSDecimalNumber(string: change), percentChange: percentChangeNumber / 100)

    }
   
}

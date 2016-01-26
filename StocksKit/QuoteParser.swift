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
        
        return Quote(symbol: symbol, name: name, exchange: exchange, currency: currency, lastTradePrice: NSDecimalNumber(string: lastTradePrice))

    }
   
}

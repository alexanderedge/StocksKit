//
//  ExchangeRateResponseSerializer.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

struct ExchangeRateResponseSerializer {
    
    enum ExchangeRateError: ErrorType {
        case MissingRate
    }
    
    static func serializer() -> ResponseSerializer <[ExchangeRate]> {
        return ResponseSerializer <[ExchangeRate]> { data, response, error in
            let query = try YahooQueryResponseSerializer.serializer().serializeResponse(data, response: response, error: error)
            if let jsonArray = query.results["rate"] as? [[String : AnyObject]] {
                return ExchangeRateParser.parse(jsonArray)
            } else if let jsonObject = query.results["rate"] as? [String : AnyObject] {
                return [try ExchangeRateParser.parse(jsonObject)]
            } else {
                throw ExchangeRateError.MissingRate
            }
        }
    }
    
}

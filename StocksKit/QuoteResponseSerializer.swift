//
//  QuoteResponseSerializer.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

struct QuoteResponseSerializer {
    
    enum QuoteError: ErrorType {
        case MissingQuote
    }
    
    static func serializer() -> ResponseSerializer <[Quote]> {
        return ResponseSerializer <[Quote]> { data, response, error in
            let query = try YahooQueryResponseSerializer.serializer().serializeResponse(data, response: response, error: error)
            if let jsonArray = query.results["quote"] as? [[String : AnyObject]] {
                return QuoteParser.parse(jsonArray)
            } else if let jsonObject = query.results["quote"] as? [String : AnyObject] {
                return [try QuoteParser.parse(jsonObject)]
            } else {
                throw QuoteError.MissingQuote
            }
        }
    }
    
}

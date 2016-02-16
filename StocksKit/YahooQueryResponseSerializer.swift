//
//  YahooQueryResponseSerializer.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

struct YahooQueryResponseSerializer {
    
    enum QueryError: ErrorType {
        case Unknown
        case MissingQuery
    }
    
    static func serializer() -> ResponseSerializer <Query> {
        return ResponseSerializer <Query> { data, response, error in
            if let data = data {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if let error = json["error"] as? [String : AnyObject], description = error["description"] as? String {
                    throw NSError(domain: "com.yahooapis.query", code: 0, userInfo: [NSLocalizedDescriptionKey : description])
                }
                guard let queryJSON = json["query"] as? [String : AnyObject] else {
                    throw QueryError.MissingQuery
                }
                return try QueryParser.parse(queryJSON)
            } else if let error = error {
                throw error
            } else {
                throw QueryError.Unknown
            }
        }
    }
    
}


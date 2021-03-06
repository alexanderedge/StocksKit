//
//  YahooQueryResponseSerializer.swift
//  StocksKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Alexander Edge
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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


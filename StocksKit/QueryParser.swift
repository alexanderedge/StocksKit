//
//  YQLParser.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

private struct ISO8601DateFormatter {
    
    private static let formatter : NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    static func dateFromString(string : String) -> NSDate? {
        return formatter.dateFromString(string)
    }
    
}

internal struct QueryParser : JSONParsingType {
    typealias T = Query
    
    enum QueryError : ErrorType {
        case MissingCount
        case MissingCreated
        case MissingLang
        case MissingResults
    }
    
    static func parse(json: [String : AnyObject]) throws -> T {
        
        guard let count = json["count"] as? Int else {
            throw QueryError.MissingCount
        }
        
        guard let createdString = json["created"] as? String, created = ISO8601DateFormatter.dateFromString(createdString) else {
            throw QueryError.MissingCreated
        }
        
        guard let lang = json["lang"] as? String else {
            throw QueryError.MissingLang
        }
        
        guard let results = json["results"] as? [String : AnyObject] else {
            throw QueryError.MissingResults
        }
        
        return Query(count: count, created: created, lang: lang, results: results)
        
    }
    
}

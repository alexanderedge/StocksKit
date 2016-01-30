//
//  ExchangeRateParser.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

private struct ExchangeRateDateFormatter {
    
    private static let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mma"
        return formatter
        
    }()
    
    static func dateFromString(string : String) -> NSDate? {
        return formatter.dateFromString(string)
    }
    
}


internal struct ExchangeRateParser : JSONParsingType {
    typealias T = ExchangeRate
    
    private static var dateFormatter: NSDateFormatter = {
       
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mma"
        return formatter
        
    }()
    
    enum ExchangeRateError : ErrorType {
        case MissingOrInvalidIdentifier
        case MissingOrInvalidName
        case MissingOrInvalidRate
        case MissingOrInvalidDate
        case MissingOrInvalidTime
        case UnableToParseDate
    }
    
    func parse(json: [String : AnyObject]) throws -> T {
        
        guard let identifier = json["id"] as? String else {
            throw ExchangeRateError.MissingOrInvalidIdentifier
        }
        
        guard let name = json["Name"] as? String else {
            throw ExchangeRateError.MissingOrInvalidName
        }
        
        let currencies = name.componentsSeparatedByString("/")
        guard let from = currencies.first else {
            throw ExchangeRateError.MissingOrInvalidName
        }
        
        guard let to = currencies.last else {
            throw ExchangeRateError.MissingOrInvalidName
        }
        
        guard let rate = json["Rate"] as? String else {
            throw ExchangeRateError.MissingOrInvalidRate
        }
        
        guard let dateString = json["Date"] as? String else {
            throw ExchangeRateError.MissingOrInvalidDate
        }
        
        guard let timeString = json["Time"] as? String else {
            throw ExchangeRateError.MissingOrInvalidTime
        }
        
        guard let date = ExchangeRateDateFormatter.dateFromString([dateString,timeString].joinWithSeparator(" ")) else {
            throw ExchangeRateError.UnableToParseDate
        }

        return ExchangeRate(identifier: identifier, from: from, to: to, rate: NSDecimalNumber(string: rate), date: date)
        
    }
    
}
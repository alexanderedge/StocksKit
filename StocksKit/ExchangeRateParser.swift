//
//  ExchangeRateParser.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

struct ExchangeRateParser : JSONParsingType {
    typealias T = ExchangeRate
    
    enum ExchangeRateError : ErrorType {
        case MissingOrInvalidIdentifier
        case MissingOrInvalidName
        case MissingOrInvalidRate
    }
    
    func parse(json: [String : AnyObject]) throws -> T {
        
        guard let identifier = json["id"] as? String else {
            throw ExchangeRateError.MissingOrInvalidIdentifier
        }
        
        guard let name = json["Name"] as? String else {
            throw ExchangeRateError.MissingOrInvalidName
        }
        
        guard let rate = json["Rate"] as? String else {
            throw ExchangeRateError.MissingOrInvalidRate
        }
        
        return ExchangeRate(identifier: identifier, name: name, rate: NSDecimalNumber(string: rate))
        
    }
    
}
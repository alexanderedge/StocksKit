//
//  ExchangeRate.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public struct ExchangeRate {
    
    public let identifier: String
    public let from: String
    public let to: String
    public let rate: NSDecimalNumber
    public let date: NSDate
    
}

public extension ExchangeRate {
    
    public static func fetch(pair : String, completionHandler: Result<[ExchangeRate], NSError> -> Void) -> NSURLSessionDataTask {
        return self.fetch([pair], completionHandler: completionHandler)
    }
    
    public static func fetch(pair : [String], completionHandler: Result<[ExchangeRate], NSError> -> Void) -> NSURLSessionDataTask {
        return NSURLSession.sharedSession().dataTaskWithRequest(Router.ExchangeRates.Fetch(pair).URLRequest, completionHandler: completionHandler)
    }
    
}

extension NSURLSession {
    
    public func dataTaskWithRequest(request: NSURLRequest, completionHandler: Result<[ExchangeRate], NSError> -> Void) -> NSURLSessionDataTask {
        return dataTaskWithRequest(request, responseSerializer: ExchangeRateResponseSerializer.serializer(), completionHandler: completionHandler)
    }
    
}
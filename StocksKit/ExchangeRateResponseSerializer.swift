//
//  ExchangeRateResponseSerializer.swift
//  StocksKit
//
//  Created by Alexander Edge on 27/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    
    public static func ExchangeRateResponseSerializer() -> ResponseSerializer<[ExchangeRate], NSError> {
        return ResponseSerializer { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            let yahooQueryResponseSerializer = Request.YahooQueryResponseSerializer()
            let result = yahooQueryResponseSerializer.serializeResponse(request, response, data, error)
            switch result {
            case .Success(let query):
                do {
                    if let jsonArray = query.results["rate"] as? [[String : AnyObject]] {
                        return .Success(ExchangeRateParser().parse(jsonArray))
                    } else if let jsonObject = query.results["rate"] as? [String : AnyObject] {
                        return .Success([try ExchangeRateParser().parse(jsonObject)])
                    } else {
                        throw Error.errorWithCode(.JSONSerializationFailed, failureReason: "missing 'rate'")
                    }
                } catch {
                    return .Failure(error as NSError)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
    }
    
    public func responseExchangeRates(completionHandler: Response<[ExchangeRate], NSError> -> Void) -> Self {
        return response(responseSerializer: Request.ExchangeRateResponseSerializer(), completionHandler: completionHandler)
    }
    
}
//
//  QuoteResponseSerializer.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    
    public static func QuoteResponseSerializer() -> ResponseSerializer<[Quote], NSError> {
        return ResponseSerializer { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            let yahooQueryResponseSerializer = Request.YahooQueryResponseSerializer()
            let result = yahooQueryResponseSerializer.serializeResponse(request, response, data, error)
            switch result {
            case .Success(let query):
                do {
                    if let jsonArray = query.results["quote"] as? [[String : AnyObject]] {
                        return .Success(QuoteParser().parse(jsonArray))
                    } else if let jsonObject = query.results["quote"] as? [String : AnyObject] {
                        return .Success([try QuoteParser().parse(jsonObject)])
                    } else {
                        throw Error.errorWithCode(.JSONSerializationFailed, failureReason: "missing 'quote'")
                    }
                } catch {
                    return .Failure(error as NSError)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
    }
    
    public func responseQuotes(completionHandler: Response<[Quote], NSError> -> Void) -> Self {
        return response(responseSerializer: Request.QuoteResponseSerializer(), completionHandler: completionHandler)
    }

}

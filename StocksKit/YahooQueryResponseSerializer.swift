//
//  YahooQueryResponseSerializer.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    
    static func YahooQueryResponseSerializer() -> ResponseSerializer<Query, NSError> {
        return ResponseSerializer { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            switch result {
            case .Success(let json):
                do {
                    guard let json = json as? [String : AnyObject] else {
                        throw Error.errorWithCode(.JSONSerializationFailed, failureReason: "root is not an object")
                    }
                    if let error = json["error"] as? [String : AnyObject], description = error["description"] as? String {
                        throw NSError(domain: "com.yahooapis.query", code: 0, userInfo: [NSLocalizedDescriptionKey : description])
                    }
                    guard let queryJSON = json["query"] as? [String : AnyObject] else {
                        throw Error.errorWithCode(.JSONSerializationFailed, failureReason: "missing 'query'")
                    }
                    return .Success(try QueryParser().parse(queryJSON))
                } catch {
                    return .Failure(error as NSError)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
    }
    
    func responseYahooQuery(completionHandler: Response<Query, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.YahooQueryResponseSerializer(), completionHandler: completionHandler)
    }
    
}

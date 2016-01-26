//
//  Router.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

struct Router {
    
    private static var baseURL : NSURL {
        return NSURL(string : "https://query.yahooapis.com")!
    }
    
    private static func requestForPath(path : String, method : Alamofire.Method) -> NSMutableURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: Router.baseURL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        return mutableURLRequest
    }
    
    enum Quotes : URLRequestConvertible {
        case Fetch([String])
        
        var method : Alamofire.Method {
            return .GET
        }
        
        var path : String {
            switch self {
            case .Fetch:
                return "/v1/public/yql"
            }
        }
        
        var URLRequest: NSMutableURLRequest {
            let request = Router.requestForPath(path, method: method)
            
            switch self {
            case .Fetch(let symbols):
                var params = [String : AnyObject]()
                params["q"] = "select * from yahoo.finance.quotes where symbol=\"\(symbols.joinWithSeparator(","))\""
                params["format"] = "json"
                params["env"] = "store://datatables.org/alltableswithkeys"
                return Alamofire.ParameterEncoding.URL.encode(request, parameters: params).0
            }
        }
    }
}
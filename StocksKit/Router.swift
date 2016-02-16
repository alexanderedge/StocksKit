//
//  Router.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public protocol URLRequestConvertible {
    /// The URL request.
    var URLRequest: NSURLRequest { get }
}

enum Method: String {
    case GET
}

struct Router {
    
    private static var baseURL : NSURL {
        return NSURL(string : "https://query.yahooapis.com")!
    }
    
    private static func requestForPath(path : String, method : Method) -> NSMutableURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: Router.baseURL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        return mutableURLRequest
    }
    
    enum Quotes : URLRequestConvertible {
        case Fetch([String])
        
        var method : Method {
            return .GET
        }
        
        var path : String {
            switch self {
            case .Fetch:
                return "/v1/public/yql"
            }
        }
        
        var URLRequest: NSURLRequest {
            switch self {
            case .Fetch(let symbols):
                var params = [String : String]()
                params["q"] = "select * from yahoo.finance.quotes where symbol=\"\(symbols.joinWithSeparator(","))\""
                params["format"] = "json"
                params["env"] = "store://datatables.org/alltableswithkeys"
                let URLComponents = NSURLComponents(URL: NSURL(string: path, relativeToURL: Router.baseURL)!, resolvingAgainstBaseURL: true)!
                URLComponents.queryItems = params.map({NSURLQueryItem(name: $0, value: $1)})
                let url = URLComponents.URL!
                return NSURLRequest(URL: url)
            }
        }
    }
    
    enum ExchangeRates : URLRequestConvertible {
        case Fetch([String])
        
        var method : Method {
            return .GET
        }
        
        var path : String {
            switch self {
            case .Fetch:
                return "/v1/public/yql"
            }
        }
        
        var URLRequest: NSURLRequest {
            switch self {
            case .Fetch(let pairs):
                var params = [String : String]()
                let pairsInCommas = pairs.map({"\"\($0)\""})
                params["q"] = "select * from yahoo.finance.xchange where pair in (\(pairsInCommas.joinWithSeparator(",")))"
                params["format"] = "json"
                params["env"] = "store://datatables.org/alltableswithkeys"
                let URLComponents = NSURLComponents(URL: NSURL(string: path, relativeToURL: Router.baseURL)!, resolvingAgainstBaseURL: true)!
                URLComponents.queryItems = params.map({NSURLQueryItem(name: $0, value: $1)})
                let url = URLComponents.URL!
                return NSURLRequest(URL: url)
            }
        }
    }
}


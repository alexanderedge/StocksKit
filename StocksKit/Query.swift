//
//  YQLResponse.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

struct Query {
    
    var count : Int
    var created : NSDate
    var lang : String
    var results : [String : AnyObject]
    
}



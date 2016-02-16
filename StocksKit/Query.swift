//
//  YQLResponse.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

struct Query {
    
    let count : Int
    let created : NSDate
    let lang : String
    let results : [String : AnyObject]
    
}



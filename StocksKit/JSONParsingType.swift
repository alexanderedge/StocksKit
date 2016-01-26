//
//  JSONParsingType.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation
import Alamofire

protocol JSONParsingType {
    typealias T
    func parse(json : [String : AnyObject]) throws -> T
    func parse(json : [[String : AnyObject]]) -> [T]
}

extension JSONParsingType {
    func parse(json : [[String : AnyObject]]) -> [T] {
        var array : [T] = []
        for jsonDic in json {
            do {
                let obj = try self.parse(jsonDic)
                array.append(obj)
            } catch {
                print("parse error: \(error)")
            }
        }
        return array
    }
}

//
//  ISO8601DateFormatter.swift
//  Stocks
//
//  Created by Alexander Edge on 19/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

struct ISO8601DateFormatter {
    
    private static let formatter : NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    static func dateFromString(string : String) -> NSDate? {
        return formatter.dateFromString(string)
    }
    
    static func stringFromDate(date : NSDate) -> String {
        return self.formatter.stringFromDate(date)
    }
    
}
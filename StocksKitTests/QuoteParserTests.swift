//
//  QuoteTest.swift
//  StocksKit
//
//  Created by Alexander Edge on 20/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import XCTest
@testable import StocksKit

class QuoteParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func testJSON() throws -> [String: AnyObject] {
        return try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("Quote", ofType: "json")!)!, options: []) as! [String: AnyObject]
    }
    
    func testParsesValidJSON() {
        
        do {

            let quote = try QuoteParser().parse(testJSON())
            
            XCTAssertEqual(quote.symbol, "ARM.L")
            XCTAssertEqual(quote.lastTradePrice, NSDecimalNumber(double: 1001.0000))
            XCTAssertEqual(quote.currency, "GBp")
            XCTAssertEqual(quote.exchange, "LSE")
            XCTAssertEqual(quote.change, NSDecimalNumber(double: -13.9999))
            XCTAssertEqualWithAccuracy(quote.percentChange.doubleValue, NSDecimalNumber(double: -0.013793).doubleValue, accuracy: DBL_EPSILON)
            
        } catch {
            XCTFail()
        }
        
    }
    
}
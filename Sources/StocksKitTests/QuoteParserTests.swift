//
//  QuoteTest.swift
//  StocksKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Alexander Edge
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
    
    func testParsesNegativeChange() {
        
        do {

            let quote = try QuoteParser.parse(testJSON())
            
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
    
    func testParsesPositiveChange() {
        
        do {
            
            var json = try testJSON()
            json["ChangeinPercent"] = "+1.3793%"
            json["Change"] = "13.9999"
            
            let quote = try QuoteParser.parse(json)
            
            XCTAssertEqual(quote.symbol, "ARM.L")
            XCTAssertEqual(quote.lastTradePrice, NSDecimalNumber(double: 1001.0000))
            XCTAssertEqual(quote.currency, "GBp")
            XCTAssertEqual(quote.exchange, "LSE")
            XCTAssertEqual(quote.change, NSDecimalNumber(double: 13.9999))
            XCTAssertEqualWithAccuracy(quote.percentChange.doubleValue, NSDecimalNumber(double: 0.013793).doubleValue, accuracy: DBL_EPSILON)
            
        } catch {
            XCTFail()
        }
        
    }
    
}
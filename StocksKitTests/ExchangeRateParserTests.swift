//
//  ExchangeRateParserTests.swift
//  StocksKit
//
//  Created by Alexander Edge on 30/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import XCTest
@testable import StocksKit

class ExchangeRateParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func testJSON() throws -> [String: AnyObject] {
        return try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("ExchangeRate", ofType: "json")!)!, options: []) as! [String: AnyObject]
    }
    
    func testParsesValidJSON() {
        
        do {
            
            let exchange = try ExchangeRateParser().parse(testJSON())
            
            XCTAssertEqual(exchange.identifier, "EURUSD")
            XCTAssertEqual(exchange.to, "USD")
            XCTAssertEqual(exchange.from, "EUR")
            XCTAssertEqual(exchange.rate, NSDecimalNumber(double: 1.0831))
            
            let dateComponents = NSDateComponents()
            dateComponents.year = 2016
            dateComponents.month = 1
            dateComponents.day = 30
            dateComponents.hour = 12
            dateComponents.minute = 53
        
            XCTAssertEqual(exchange.date, NSCalendar.currentCalendar().dateFromComponents(dateComponents))
            
        } catch {
            XCTFail()
        }
        
    }
    
}
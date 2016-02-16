//
//  QueryTest.swift
//  StocksKit
//
//  Created by Alexander Edge on 20/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import XCTest
@testable import StocksKit

class QueryParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func testJSON() throws -> [String: AnyObject] {
        return try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("Query", ofType: "json")!)!, options: []) as! [String: AnyObject]
    }
    
    func testParsesValidJSON() {
        
        do {
            
            let query = try QueryParser.parse(testJSON())
            
            XCTAssertEqual(query.count, 2)
            
            let dateComponents = NSDateComponents()
            dateComponents.year = 2016
            dateComponents.month = 1
            dateComponents.day = 30
            dateComponents.hour = 16
            dateComponents.minute = 47
            dateComponents.second = 54
            
            XCTAssertEqual(query.created, NSCalendar.currentCalendar().dateFromComponents(dateComponents))
            XCTAssertEqual(query.lang, "en-US")
            
     
            XCTAssertTrue(query.results["rate"] is [[String: AnyObject]])
            
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
}
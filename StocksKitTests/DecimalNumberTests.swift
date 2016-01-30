//
//  DecimalNumberTests.swift
//  StocksKit
//
//  Created by Alexander Edge on 30/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import XCTest
@testable import StocksKit

class DecimalNumberTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAddition() {
        let number: NSDecimalNumber = 23.52
        let add: NSDecimalNumber = 2
        XCTAssertEqual(number + add, 25.52)
    }
    
    func testSubtraction() {
        let number: NSDecimalNumber = 23.52
        let subtract: NSDecimalNumber = 2
        XCTAssertEqual(number - subtract, 21.52)
    }
    
    func testDivision() {
        let dividend: NSDecimalNumber = 23.52
        let divisor: NSDecimalNumber = 2
        XCTAssertEqual(dividend / divisor, 11.76)
    }
    
    func testMultiplication() {
        let multiplier: NSDecimalNumber = 23.52
        let multiplicand: NSDecimalNumber = 2
        XCTAssertEqual(multiplier * multiplicand, 47.04)
    }
    
}
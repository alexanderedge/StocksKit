//
//  OrderTests.swift
//  StocksKit
//
//  Created by Alexander Edge on 20/01/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import XCTest
@testable import StocksKit

public func ~=(lhs: ErrorType, rhs: ErrorType) -> Bool {
    return lhs._domain == rhs._domain
        && lhs._code   == rhs._code
}

func AssertThrow<R>(expectedError: ErrorType, @autoclosure _ closure: () throws -> R) -> () {
    do {
        try closure()
        XCTFail("Expected error \"\(expectedError)\", "
            + "but closure succeeded.")
    } catch expectedError {
        // Expected.
    } catch {
        XCTFail("Caught error \"\(error)\", "
            + "but not from the expected type "
            + "\"\(expectedError)\".")
    }
}

class OrderTests: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()

        
    }
    
    override func tearDown() {
        
        
        
        super.tearDown()
    }
    
    func testCost() {
        let order = Order(symbol: "FOO", quantity: 30, price: 1.4, currency: "USD", exchangeRate: 1, baseCurrency: "USD", commission: 10.5)
        let cost = order.cost
        XCTAssertEqual(cost, NSDecimalNumber(double: 52.5))
    }
    
    func testCurrentValue() {
        let order = Order(symbol: "FOO", quantity: 30, price: 1.4, currency: "USD", exchangeRate: 1, baseCurrency: "USD", commission: 10.5)
        let quote = Quote(symbol: "FOO", name: "ACME INC", currency: "USD", lastTradePrice: 1.6)
        do {
            let currentValue = try order.currentValue(quote)
            XCTAssertEqual(currentValue, NSDecimalNumber(double: 48))
        } catch {
            XCTFail()
        }
    }    
    
    func testCurrentValueThrowsForSymbolMismatch() {
        let order = Order(symbol: "FOO", quantity: 30, price: 1.4, currency: "USD", exchangeRate: 1, baseCurrency: "USD", commission: 10.5)
        let quote = Quote(symbol: "BAR", name: "ACME INC", currency: "USD", lastTradePrice: 1.6)
        AssertThrow(Order.OrderError.IncompatibleSymbol, try order.currentValue(quote))
    }
    
    func testCurrentValueThrowsForCurrencyMismatch() {
        let order = Order(symbol: "FOO", quantity: 30, price: 1.4, currency: "USD", exchangeRate: 1, baseCurrency: "USD", commission: 10.5)
        let quote = Quote(symbol: "FOO", name: "ACME INC", currency: "GBP", lastTradePrice: 1.6)
        AssertThrow(Order.OrderError.IncompatibleCurrency, try order.currentValue(quote))
    }
    
}

//
//  Result.swift
//  StocksKit
//
//  Created by Alexander Edge on 15/02/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

public enum Result <Value, Error: ErrorType> {
    case Success(Value)
    case Failure(Error)
}
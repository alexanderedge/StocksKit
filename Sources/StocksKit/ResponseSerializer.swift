//
//  ResponseSerializer.swift
//  StocksKit
//
//  Created by Alexander Edge on 15/02/2016.
//  Copyright © 2016 Alexander Edge. All rights reserved.
//

import Foundation

internal protocol ResponseSerializerType {
    typealias T
    
    func serializeResponse(data: NSData?, response: NSURLResponse?, error: NSError?) throws -> T
    
}

internal struct ResponseSerializer<T>: ResponseSerializerType {
    
    typealias SerializationBlock = (NSData?, NSURLResponse?, NSError?) throws -> T
    
    let serializationBlock: SerializationBlock
    
    init(serializationBlock: SerializationBlock) {
        self.serializationBlock = serializationBlock
    }
    
    func serializeResponse(data: NSData?, response: NSURLResponse?, error: NSError?) throws -> T {
        return try serializationBlock(data, response, error)
    }
    
}

extension NSURLSession {
    
    internal func dataTaskWithRequest<T>(request: NSURLRequest, responseSerializer: ResponseSerializer<[T]>,completionHandler: Result<[T], NSError> -> Void) -> NSURLSessionDataTask {
        return dataTaskWithRequest(request) { data, response, error in
            do {
                let objects = try responseSerializer.serializeResponse(data, response: response, error: error)
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(.Success(objects))
                }
            } catch {
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(.Failure(error as NSError))
                }
            }
        }
    }
    
}
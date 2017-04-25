//
//  Helpers.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 25.04.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    enum SerializationError: Error {
        case CastError
    }
    
    func value<T>(by key: String) throws -> T {
        guard let value = self[key] as? T else { throw SerializationError.CastError }
        return value
    }
}

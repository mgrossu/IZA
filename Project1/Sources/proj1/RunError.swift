//
//  RunError.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//

enum RunError: Error {
    // *******************
    // * NOT IMPLEMENTED *
    // *******************
    case notImplemented
}

// MARK: - Return codes
extension RunError {
    var code: Int {
        switch self {
        case .notImplemented:
            return 66
        // *******************
        // * NOT IMPLEMENTED *
        // *******************
        }
    }
}

// MARK:- Description of error
extension RunError: CustomStringConvertible {
    var description: String {
        switch self {
        case .notImplemented:
            return "Not implemented"
        // *******************
        // * NOT IMPLEMENTED *
        // *******************
        }
    }
}

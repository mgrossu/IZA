//
//  RunError.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//

enum RunError: Error {
    case wrongInputString
    case wrongArguments
    case fileError
    case automataDecodeError
    case undefinedState
    case undefinedSymbol
    case otherError
}

// MARK: - Return codes
extension RunError {
    var code: Int {
        switch self {
        case .wrongInputString:
            return 6
        case .wrongArguments:
            return 11
        case .fileError:
            return 12
        case .automataDecodeError:
            return 20
        case .undefinedState:
            return 21
        case .undefinedSymbol:
            return 22
        case .otherError:
            return 99
        }
    }
}

// MARK:- Description of error
extension RunError: CustomStringConvertible {
    var description: String {
        switch self {
        case .wrongInputString:
            return "Inserted string is not accepted by automata"
        case .wrongArguments:
            return "Wrong arguments"
        case .fileError:
            return "Work with files"
        case .automataDecodeError:
            return "Decoding automata"
        case .undefinedState:
            return "Automate state is undefind"
        case .undefinedSymbol:
            return "Automata symbol is undefing"
        case .otherError:
            return "Other errors"
        }
    }
}

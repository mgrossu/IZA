//
//  FiniteAutomata.swift
//  FiniteAutomata
//
//  Created by Filip Klembara on 17/02/2020.
//  
//

/// Transition
public struct Transition {
    public var with: String
    public var to: String
    public var from: String
    
    
    enum CodingKeys: String, CodingKey {
        case with
        case to
        case from
    }
}

extension Transition: Decodable {
    public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            with = try values.decode(String.self, forKey: .with)
            to = try values.decode(String.self, forKey: .to)
            from = try values.decode(String.self, forKey: .from)
        }
}
/// Finite automata
public struct FiniteAutomata {

    public var states: [String]
    public var symbols: [String]
    public var transitions: [Transition]
    public var initialState: String
    public var finalStates: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case states
        case symbols
        case transitions
        case initialState
        case finalStates
    }
}


extension FiniteAutomata: Decodable {

    public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            states = try values.decode([String].self, forKey: .states)
            symbols = try values.decode([String].self, forKey: .symbols)
            transitions = try values.decode([Transition].self, forKey: .transitions)
            initialState = try values.decode(String.self, forKey: .initialState)
            finalStates = try values.decode([String].self, forKey: .finalStates)
        
        }
}

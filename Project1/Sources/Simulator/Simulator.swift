//
//  Simulator.swift
//  Simulator
//
//  Created by Filip Klembara on 17/02/2020.
//

import FiniteAutomata

/// Simulator
public struct Simulator {
    /// Finite automata used in simulations
    private let finiteAutomata: FiniteAutomata

    /// Initialize simulator with given automata
    /// - Parameter finiteAutomata: finite automata
    public init(finiteAutomata: FiniteAutomata) {
        self.finiteAutomata = finiteAutomata
    }

    /// Simulate automata on given string
    /// - Parameter string: string with symbols separated by ','
    /// - Returns: Empty array if given string is not accepted by automata,
    ///     otherwise array of states
    public func simulate(on string: String) -> [String] {
        // *******************
        // * NOT IMPLEMENTED *
        // *******************
        return []
    }
}

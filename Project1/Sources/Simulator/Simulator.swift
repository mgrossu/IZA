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

      let symbol_array = string.split(separator: ",")
      let initial_state = finiteAutomata.initialState
      var current_state = [initial_state]


      for current_symbol in symbol_array {
        var next : [String] = []
        for state in current_state{
            for transition in finiteAutomata.transitions{
                if transition.from == state && transition.with == current_symbol{
                    next.append(transition.to)
                }
            }
            //let new_state = check_transitions(state: state, symbol: String(current_symbol))
           // if new_state != "" {
            //  next.append(new_state)
            //}
        }
        current_state=next
      }
        

        // return states if last state is final
        let output = current_state.filter(finiteAutomata.finalStates.contains)
        if output.count > 0 {
            return current_state
        }
        else {
            return []
        }
    }
    
//    private func check_transitions(state: String, symbol: String) -> String {
//      for transition in finiteAutomata.transitions {
//        if transition.from == state && transition.with == symbol {
//            return transition.to
//        }
//      }
 //     return ""
//    }
    
}

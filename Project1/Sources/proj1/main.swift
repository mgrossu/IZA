//
//  main.swift
//  proj1
//
//  Created by Filip Klembara on 17/02/2020.
//  

import Foundation
import FiniteAutomata
import Simulator

// MARK: - Main
func main() -> Result<Void, RunError> {

    if CommandLine.argc != 3 {
        return .failure(.wrongArguments)
    }
    // JSON parsing
    let automata: FiniteAutomata
    let dict: String
    do {
    dict = try String(contentsOfFile: CommandLine.arguments[2], encoding: String.Encoding.utf8)
    } catch {
        return .failure(.fileError)
    }
    do {
        let data = dict.data(using: .utf8)!
        automata = try JSONDecoder().decode(FiniteAutomata.self, from: data)
    } catch {
        return .failure(.automataDecodeError)
    }
    // Check States and Symbols
    let error: RunError? = check_states_symbols(finiteAutomata: automata)
    if error != nil {
        return .failure(error!)
    }
    // Simulator
    let simulator = Simulator(finiteAutomata: automata)
    let simulator_rc = simulator.simulate(on: CommandLine.arguments[1])

    if simulator_rc == [] {
        return .failure(.wrongInputString)
    }
    for value in simulator_rc {
        print(value)
    }

    return .success(())
}

private func check_states_symbols(finiteAutomata: FiniteAutomata) -> RunError? {
  for transition in finiteAutomata.transitions {
    if !finiteAutomata.symbols.contains(transition.with) {
      return .undefinedSymbol
    }
    if !finiteAutomata.states.contains(transition.from) {
      return .undefinedState
    }
    if !finiteAutomata.states.contains(transition.to) {
      return .undefinedState
    }
  }
  return nil
}

// MARK: - program body
let result = main()

switch result {
case .success:
    break
case .failure(let error):
    var stderr = STDERRStream()
    print("Error:", error.description, to: &stderr)
    exit(Int32(error.code))
}

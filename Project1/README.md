## Assignment

Implement a program in swift that simulates the transition to the states required to accept a string for a given input string and nondeterministic finite state machine. If the string is accepted by the terminated automaton, the sequence of states is written to stdout. If the string is not accepted, the program ends with an error. The tested automata will contain at most one sequence of states for receiving input.

### Running the program

The program can be run using the command `swift run proj1 <input_string> <file_name>` in the program's home folder (the folder containing the * Package.swift * file).

- `<input_string>` - contains individual symbols separated by `,` (comma), eg:
   - `swift run proj1 a, b, c automata.json`: input string contains three symbols,
   - `swift run proj1 "" automata.json`: input string contains no symbol.
- `<file_name>` - path to the file containing the finite state machine representation saved in JSON format.

### JSON attributes

- states - array of strings containing individual states,
- symbols - an array of strings containing individual symbols,
- transitions - field of transitions, where each transition ($ `pa \ rightarrow q` $) contains attributes:
    - from - current state $ `q` $,
    - with - current symbol $ `a` $,
    - to - new state $ `q` $,
- initialState,
- finalStates - field of final states.





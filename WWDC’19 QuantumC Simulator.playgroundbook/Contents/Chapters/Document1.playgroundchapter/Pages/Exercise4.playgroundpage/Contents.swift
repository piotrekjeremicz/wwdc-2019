//#-hidden-code
//
//  Contents.swift
//
//  Copyright © 2019 - Piotr Jeremicz
//
//#-end-hidden-code
/*:
 # 💰 Coin flip 💰
 
 Quantum Computer is much more powerful than classical devices. It could be used to solve the hardest mathematical problems. It could be used to train the ML Models or break the RSA key.
 
 * callout(Wow 🤯):
It is awesome! Is there some magical powers that could calculate everyting 🧐?
 
 The answear is: YES 👍
 
 The Quantum Computer is a future of IT technology. Today we will use it to calculate very complicated problem. A coin flip 🤪.
 */
//#-hidden-code
//#-code-completion(everything, hide)
import PlaygroundSupport

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true

let qComputerViewController = QuantumComputerViewController()
//#-end-hidden-code
let qComputer = Computer(qubits: 4)
qComputer.initialize(value: 1)
//#-hidden-code
qComputerViewController.registerKetChange(qComputer.register)
//#-end-hidden-code
qComputer.apply(gate: Gate.hadamard(n: 1))
//#-hidden-code
qComputerViewController.registerKetChange(qComputer.register)
//#-end-hidden-code
qComputer.collapse()

// It is our answer
let value = qComputer.value
//#-hidden-code
qComputerViewController.registerKetChange(qComputer.register)
//#-end-hidden-code

//You can change the coin sides values
let heads: String = /*#-editable-code*/"🌕"/*#-end-editable-code*/
let tails: String = /*#-editable-code*/"🌑"/*#-end-editable-code*/
//#-hidden-code
page.liveView = qComputerViewController

var result = "The result is: "

if qComputer.value == 1 {
    result += tails
} else {
    result += heads
}

qComputerViewController.run() {
    page.assessmentStatus = .pass(message: "\(result). Go to the [next page](@next) or run the code again.")
}
//#-end-hidden-code

// Run the code ▶️

//#-hidden-code
//
//  Contents.swift
//
//  Copyright 2019 Piotr Jeremicz.
//
//#-end-hidden-code
/*:
 # Quantum Computer Simuator

 Right now you are ready to make your first program for Quantum Computer 🥳.
 
 To change the initial state of the register, you have to apply the gate. There are many types of gates. Each of them contains different vectors or matrices that convert the basic state.
 
 Okey, have a nice play! ✌️
 */
//#-hidden-code
//#-code-completion(everything, hide)
import PlaygroundSupport

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true

func applyGates(_ gates: [Gate], to computer: Computer) {
    for gate in gates {
        computer.apply(gate: gate)
        qComputerViewController.registerKetChange(computer.register)
    }
}

let qComputerViewController = QuantumComputerViewController()
//#-end-hidden-code
let quantumComputer = Computer(qubits: 4)
quantumComputer.initialize(value: /*#-editable-code*/1/*#-end-editable-code*/)
//#-hidden-code
qComputerViewController.registerKetChange(quantumComputer.register)
//#-code-completion(identifier, show, Gate, ., comma)
//#-code-completion(identifier, show, identity(width:), hadamard(n:), pauliX(), pauliY(), pauliZ(), phaseShift(phi:), swap(), sqrtSwap(), controlledNot(), controlled(by:), controlledX(), controlledY(), controlledZ(), toffoli())
//#-end-hidden-code
applyGates([
    //#-editable-code
    Gate.hadamard(n: 2),
    Gate.deutschGate(fn: [1, 0]),
    Gate.phaseShift(phi: 0.9),
    Gate.pauliZ()
    //#-end-editable-code
    ], to: quantumComputer)

quantumComputer.collapse()
//#-hidden-code
qComputerViewController.registerKetChange(quantumComputer.register)
page.liveView = qComputerViewController

qComputerViewController.run() {
    page.assessmentStatus = .pass(message: "That is all! 🎉 The future is still ahead. Current computer technology is approaching the limits of physics. A breakthrough is needed that will revolutionize the market again. The Monday event will bring us new amazing 🍏 products. Maybe in the near future we will hear again on TV: \"And you'll see why 1984 won't be like 1984!\" Have a nice day!")
}
//#-end-hidden-code

// Run the code and later try to change the code ▶️

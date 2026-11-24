//#-hidden-code
//
//  Contents.swift
//
//  Copyright © 2019 - Piotr Jeremicz
//
//#-end-hidden-code
/*:
  # Quantum Bit
 
 **Quantum Bit** is the basic unit of the quantum information. To simplify the theory the Qubit could be presented as a sphere with specific points. We call them superpositions 👨‍🏫.
 
 The matrix of the Complex Numbers can be used to represent the quantum bit. We will close it inside our Quantum Computer:
 */
let qComputer = Computer(qubits: 1)
/*:
 Qubits will be hidden inside the register that will contain the Ket which will be the representation of the Qubit information.
*/
//#-hidden-code
var qRegister: QuantumRegister = QuantumRegister(width: 0, initial: ClassicalRegister(bits: []))
let cRegister: ClassicalRegister?
//#-end-hidden-code
//#-editable-code
switch qComputer.state {
case .undefined, .run:
    qRegister = qComputer.register as! QuantumRegister
case .stable:
    cRegister = qComputer.register as! ClassicalRegister
}

let elements: [Complex] = qRegister.ket.elements
//#-end-editable-code
/*:
 Okey. We will learn how to program it! [Go to the next page](@next).
*/

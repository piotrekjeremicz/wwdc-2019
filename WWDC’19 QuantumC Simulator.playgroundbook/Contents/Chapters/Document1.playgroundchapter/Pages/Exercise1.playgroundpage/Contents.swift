//#-hidden-code
//
//  Contents.swift
//
//  Copyright 2019, Piotr Jeremicz.
//
//#-end-hidden-code
/*:
 # Classical Computer
 
 Today we will jump into the future where computers will be not the same as they are today 🤖.
 
 Nowadays, our computers are created from billions of transistors. These small electric logic gates calculate unimaginable number of data. We can see their work every day sitting in front of our devices 👨‍💻👩‍💻.
 
 Each electronic device is based on a simple principle where we have two states:
 - 0️⃣ - false
 - 1️⃣ - true
 
 Great! Let's create our 8 bit computer with initial state and apply basic operations through operators
 */
//#-hidden-code
//#-code-completion(everything, hide)
import PlaygroundSupport

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true

let bitViewController = BitComputerViewController()
//#-end-hidden-code
let bitComputer = Computer(bits: 8)
//#-hidden-code
bitViewController.addStep(computer: bitComputer, description: "Create computer")
//#-end-hidden-code
bitComputer.initialize(value: /*#-editable-code*/<#T##Int Value##Int#>/*#-end-editable-code*/)
//#-hidden-code
bitViewController.addStep(computer: bitComputer, description: "Initialize state")
//#-end-hidden-code

//#-hidden-code
//#-code-completion(identifier, show, .)
//#-code-completion(identifier, show, Operator, addition(value:), substraction(value:), multiplication(value:), division(value:))
//#-end-hidden-code
bitComputer.apply(operation: /*#-editable-code*/<#T##Operator#>/*#-end-editable-code*/)
//#-hidden-code
bitViewController.addStep(computer: bitComputer, description: "Apply operation")
//#-end-hidden-code
bitComputer.apply(operation: /*#-editable-code*/<#T##Operator#>/*#-end-editable-code*/)
//#-hidden-code
bitViewController.addStep(computer: bitComputer, description: "Apply operation")

page.liveView = bitViewController

bitViewController.addStep(computer: bitComputer, description: "Done. Final result")
bitViewController.run() {
    page.assessmentStatus = .pass(message: "Go to the [next page](@next)")
}
//#-end-hidden-code

// Now you can run the code ▶️

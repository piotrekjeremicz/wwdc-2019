//#-hidden-code
//
//  Contents.swift
//
//  Copyright 2019 Piotr Jeremicz.
//
//#-end-hidden-code
/*:
 # Complex Number
 Bit is a basic unit in digital communication. It has a lot of advantages, but there is needed to process a lot of them to show understandable data.
 
 * callout(🤔):
 Okay, that's great! But... Is there any possibility to extend the bit value?
 
 There is a mathematic constuction callen **Complex Number** that provides more information. Comlex is build from two parts: **a + bi**
 - Real (*a*)
 - Imaginery (*bi*)
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, +, +=, *, *=, -, -=, /, /=,  Complex)
//#-code-completion(identifier, show, Complex(re:im:))
import Foundation
import PlaygroundSupport
//#-end-hidden-code
//#-hidden-code
let page = PlaygroundPage.current
let chartViewController = ComplexChartViewController()

page.needsIndefiniteExecution = true
page.liveView = chartViewController

func drawComplexChart(from complex: Complex) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        chartViewController.complexLabel.text = complex.description
        chartViewController.complexChart.drawComplex(complex: complex)
    }
}
//#-end-hidden-code
var complex = Complex(re: /*#-editable-code*/<#T##Float#>/*#-end-editable-code*/, im: /*#-editable-code*/<#T##Float#>/*#-end-editable-code*/)

// Complex value, as normal number, could be a subject of mathematical operations
//#-editable-code
complex += Complex(re: 2.0, im: 4.0)
complex *= Complex(re: 3.0, im: 0.5)
//#-end-editable-code

drawComplexChart(from: complex)

// Run the code to see how the Complex Number is presenting on the chart ▶️
//#-hidden-code
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
    page.assessmentStatus = .pass(message: "Go to the [next page](@next)")
}
//#-end-hidden-code

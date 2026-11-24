//
//  BitComputerViewController.swift
//  Computer Test
//
//  Created by Piotrek on 20/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import UIKit

public class BitComputerViewController: UIViewController {
    
    public let headerLabel = UILabel()
    public let horizontalStackView = UIStackView()
    public let consoleTextView = UITextView()
    public var bitViews: [BitView] = []
    private var steps: [Step] = []
        
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 23.0/255.0, green: 24.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .light)
        self.headerLabel.textAlignment = .center
        self.headerLabel.textColor = .white
        self.headerLabel.text = "Classical Computer"
        
        self.view.addSubview(self.headerLabel)
        
        self.horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.horizontalStackView.axis = .horizontal
        self.horizontalStackView.alignment = .fill
        self.horizontalStackView.distribution = .fillEqually
        self.horizontalStackView.spacing = 0.0
        
        for i in 0...7 {
            let view = BitView(frame: .init(x: 0.0, y: 0.0, width: 43.0, height: 43.0))
            view.bitNumber.text = "B\(7-i)"
            self.bitViews.append(view)
            
            self.horizontalStackView.addArrangedSubview(view)
        }
        
        self.view.addSubview(self.horizontalStackView)
        
        self.consoleTextView.translatesAutoresizingMaskIntoConstraints = false
        self.consoleTextView.font = UIFont(name: "Courier New", size: 12.0)
        self.consoleTextView.textColor = .white
        self.consoleTextView.textAlignment = .left
        self.consoleTextView.backgroundColor = .clear
        self.consoleTextView.isEditable = false
        
        self.view.addSubview(self.consoleTextView)
        
        self.setupConstraints()
    }
    
    public func insertBits(bits: [Int]) {
        for (index, bitView) in self.bitViews.enumerated() {
            if bitView.bitLabel.text != "\(bits[7 - index])" {
                bitView.bitLabel.text = "\(bits[7 - index])"
                
                bitView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
                UIView.animate(withDuration: 0.6) {
                    bitView.backgroundColor = .white
                }
            }
        }
    }
    
    public func addStep(computer: Computer, description: String) {
        if let classical = computer.register as? ClassicalRegister {
            
            var bitString = "B"
            for i in 0...7 {
                bitString += "\(classical.bits[7 - i])"
            }
            
            if let action = classical.lastOperation {
                let step = BitComputerViewController.Step(bits: classical.bits, description: "~: \(description), \(action): \(bitString)")
                self.steps.append(step)
            } else {
                let step = BitComputerViewController.Step(bits: classical.bits, description: "~: \(description): \(bitString)")
                self.steps.append(step)
            }
            
            
        }
    }
    
    public func run(completion: @escaping () -> Void) {
        let lastStep = BitComputerViewController.Step(bits: [], description: "\n Continue to the next page...")
        self.steps.append(lastStep)
        
        for (i, step) in self.steps.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500 + i*1000)) {
                self.consoleTextView.text += "\(step.description)\n"
                
                if !step.bits.isEmpty {
                    self.insertBits(bits: step.bits)
                } else {
                    completion()
                }
            }
        }
    }
}

private extension BitComputerViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
            self.headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0),
            self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            self.horizontalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0),
            self.horizontalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0),
            self.horizontalStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
            self.horizontalStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            self.horizontalStackView.heightAnchor.constraint(equalTo: self.horizontalStackView.widthAnchor, multiplier: 0.125),
            self.consoleTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
            self.consoleTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            self.consoleTextView.topAnchor.constraint(equalTo: self.horizontalStackView.bottomAnchor, constant: 20.0),
            self.consoleTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0)
            ]
        )
    }
}

public extension BitComputerViewController {
    struct Step {
        let description: String
        let bits: [Int]
        
        init(bits: [Int], description: String) {
            self.bits = bits
            self.description = description
        }
    }
}

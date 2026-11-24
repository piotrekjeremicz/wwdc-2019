//
//  ComplexChartViewController.swift
//  Computer Test
//
//  Created by Piotrek on 21/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import UIKit

public class ComplexChartViewController: UIViewController {

    public let headerLabel = UILabel()
    public let complexLabel = UILabel()
    public let complexChart = ComplexChart()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 23.0/255.0, green: 24.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .light)
        self.headerLabel.textAlignment = .center
        self.headerLabel.textColor = .white
        self.headerLabel.text = "Complex Chart"
        
        self.view.addSubview(self.headerLabel)
        
        self.complexLabel.translatesAutoresizingMaskIntoConstraints = false
        self.complexLabel.font = UIFont.italicSystemFont(ofSize: 24.0)
        self.complexLabel.textAlignment = .center
        self.complexLabel.textColor = .white
        self.complexLabel.text = ""

        self.view.addSubview(self.complexLabel)
        
        self.complexChart.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.complexChart)
        
        self.setupConstraints()
        
        self.complexChart.drawComplex(complex: Complex(re: 0.0, im: 0.0))
    }
}

private extension ComplexChartViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
            self.headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0),
            self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),

            self.complexLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
            self.complexLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 16.0),
            self.complexLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            
            self.complexChart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0),
            self.complexChart.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0),
            self.complexChart.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 64.0),
            self.complexChart.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -64.0),
            self.complexChart.widthAnchor.constraint(equalTo: self.complexChart.heightAnchor, constant: 1.0)
            ]
        )
    }
}

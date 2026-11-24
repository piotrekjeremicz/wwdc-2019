//
//  ComplexChart.swift
//  Computer Test
//
//  Created by Piotrek on 21/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import UIKit

public class ComplexChart: UIView {
    public let leftTopLabel = UILabel()
    public let rightTopLabel = UILabel()
    public let leftBottomLabel = UILabel()
    public let rightBottomLabel = UILabel()
    
    public let leftLine = UIView()
    public let topLine = UIView()
    public let rightLine = UIView()
    public let bottomLine = UIView()
    
    private var arrowLayer = CAShapeLayer()
    private var didSetupConstraints = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.leftTopLabel.translatesAutoresizingMaskIntoConstraints = false
        self.leftTopLabel.font = UIFont.systemFont(ofSize: 8.0)
        self.leftTopLabel.textAlignment = .right
        self.leftTopLabel.textColor = .black
        self.leftTopLabel.text = "0.0"
        self.leftTopLabel.adjustsFontSizeToFitWidth = true
        self.leftTopLabel.minimumScaleFactor = 0.5
        
        self.addSubview(self.leftTopLabel)
        
        self.rightTopLabel.translatesAutoresizingMaskIntoConstraints = false
        self.rightTopLabel.font = UIFont.systemFont(ofSize: 8.0)
        self.rightTopLabel.textAlignment = .left
        self.rightTopLabel.textColor = .black
        self.rightTopLabel.text = "0.0"
        self.rightTopLabel.adjustsFontSizeToFitWidth = true
        self.rightTopLabel.minimumScaleFactor = 0.5
        
        self.addSubview(self.rightTopLabel)
        
        self.leftBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        self.leftBottomLabel.font = UIFont.systemFont(ofSize: 8.0)
        self.leftBottomLabel.textAlignment = .right
        self.leftBottomLabel.textColor = .black
        self.leftBottomLabel.text = "0.0"
        self.leftBottomLabel.adjustsFontSizeToFitWidth = true
        self.leftBottomLabel.minimumScaleFactor = 0.5
        
        self.addSubview(self.leftBottomLabel)
        
        self.rightBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        self.rightBottomLabel.font = UIFont.systemFont(ofSize: 8.0)
        self.rightBottomLabel.textAlignment = .left
        self.rightBottomLabel.textColor = .black
        self.rightBottomLabel.text = "0.0"
        self.rightBottomLabel.adjustsFontSizeToFitWidth = true
        self.rightBottomLabel.minimumScaleFactor = 0.5
        
        self.addSubview(self.rightBottomLabel)
        
        
        self.leftLine.translatesAutoresizingMaskIntoConstraints = false
        self.topLine.translatesAutoresizingMaskIntoConstraints = false
        self.rightLine.translatesAutoresizingMaskIntoConstraints = false
        self.bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.leftLine.backgroundColor = UIColor.darkGray
        self.topLine.backgroundColor = UIColor.darkGray
        self.rightLine.backgroundColor = UIColor.darkGray
        self.bottomLine.backgroundColor = UIColor.darkGray
        
        self.addSubview(self.leftLine)
        self.addSubview(self.topLine)
        self.addSubview(self.rightLine)
        self.addSubview(self.bottomLine)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: .zero)
    }
    
    override public func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
            
            NSLayoutConstraint.activate([
                    self.leftTopLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0),
                    self.leftTopLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
                    self.leftTopLabel.widthAnchor.constraint(equalToConstant: 16.0),
                    self.leftTopLabel.heightAnchor.constraint(equalToConstant: 16.0),
                    
                    self.rightTopLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0),
                    self.rightTopLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
                    self.rightTopLabel.widthAnchor.constraint(equalToConstant: 16.0),
                    self.rightTopLabel.heightAnchor.constraint(equalToConstant: 16.0),
                    
                    self.leftBottomLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0),
                    self.leftBottomLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
                    self.leftBottomLabel.widthAnchor.constraint(equalToConstant: 16.0),
                    self.leftBottomLabel.heightAnchor.constraint(equalToConstant: 16.0),
                    
                    self.rightBottomLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0),
                    self.rightBottomLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
                    self.rightBottomLabel.widthAnchor.constraint(equalToConstant: 16.0),
                    self.rightBottomLabel.heightAnchor.constraint(equalToConstant: 16.0),
                    
                    
                    self.leftLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
                    self.leftLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
                    self.leftLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                    self.leftLine.widthAnchor.constraint(equalToConstant: 1.0),
                    
                    self.topLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
                    self.topLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
                    self.topLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
                    self.topLine.heightAnchor.constraint(equalToConstant: 1.0),
                    
                    self.rightLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
                    self.rightLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
                    self.rightLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                    self.rightLine.widthAnchor.constraint(equalToConstant: 1.0),
                    
                    self.bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
                    self.bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
                    self.bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
                    self.bottomLine.heightAnchor.constraint(equalToConstant: 1.0),
                    
                ]
            )
        }
        super.updateConstraints()
    }
    
    public func drawComplex(complex: Complex) {
        self.arrowLayer.removeFromSuperlayer()
        self.arrowLayer = CAShapeLayer()
        
        var zeroPoint: CGPoint = .zero
        var endPoint: CGPoint = .zero
        var xScale: Float = 5.0
        var yScale: Float = 5.0
        
        while abs(complex.re) > xScale {
            xScale += 5.0
        }
        
        while abs(complex.im) > yScale {
            yScale += 5.0
        }
        
        if complex.re >= 0 && complex.im >= 0 {
            self.topLine.isHidden = true
            self.leftLine.isHidden = false
            self.rightLine.isHidden = true
            self.bottomLine.isHidden = false
            
            self.leftTopLabel.isHidden = false
            self.leftBottomLabel.isHidden = false
            self.rightBottomLabel.isHidden = false
            self.rightTopLabel.isHidden = true
            
            self.leftTopLabel.text = "\(yScale)"
            self.leftBottomLabel.text = "0.0"
            self.rightBottomLabel.text = "\(xScale)"
            
            zeroPoint = CGPoint(x: self.leftBottomLabel.frame.origin.x + self.leftBottomLabel.frame.size.width,
                                y: self.leftBottomLabel.frame.origin.y)
            
            endPoint = CGPoint(x: self.bottomLine.frame.size.width * CGFloat(complex.re/xScale) + self.bottomLine.frame.origin.x,
                               y: 0 - self.leftLine.frame.size.height * CGFloat(complex.im/yScale) + self.bottomLine.frame.origin.y)
            
        } else if complex.re >= 0 && complex.im < 0 {
            self.topLine.isHidden = false
            self.leftLine.isHidden = false
            self.rightLine.isHidden = true
            self.bottomLine.isHidden = true
            
            self.leftTopLabel.isHidden = false
            self.leftBottomLabel.isHidden = false
            self.rightBottomLabel.isHidden = true
            self.rightTopLabel.isHidden = false
            
            self.leftBottomLabel.text = "-\(yScale)"
            self.leftTopLabel.text = "0.0"
            self.rightTopLabel.text = "\(xScale)"
            
            zeroPoint = CGPoint(x: self.leftTopLabel.frame.origin.x + self.leftTopLabel.frame.size.width,
                                y: self.leftTopLabel.frame.origin.y + self.leftTopLabel.frame.size.height)
            
            endPoint = CGPoint(x: self.topLine.frame.size.width * CGFloat(complex.re/(complex.re + 1.0)) + self.topLine.frame.origin.x,
                               y: self.leftLine.frame.size.height * CGFloat(abs(complex.im)/(abs(complex.im) + 1.0)) + self.leftLine.frame.origin.y)
            
        } else if complex.re < 0 && complex.im < 0 {
            self.topLine.isHidden = false
            self.leftLine.isHidden = true
            self.rightLine.isHidden = false
            self.bottomLine.isHidden = true
            
            self.leftTopLabel.isHidden = false
            self.leftBottomLabel.isHidden = true
            self.rightBottomLabel.isHidden = false
            self.rightTopLabel.isHidden = false
            
            self.leftTopLabel.text = "-\(xScale)"
            self.rightTopLabel.text = "0.0"
            self.rightBottomLabel.text = "-\(yScale)"
            
            zeroPoint = CGPoint(x: self.rightTopLabel.frame.origin.x,
                                y: self.rightTopLabel.frame.origin.y + self.rightTopLabel.frame.size.height)
            endPoint = CGPoint(x: self.topLine.frame.size.width - self.topLine.frame.size.width * CGFloat(abs(complex.re)/(abs(complex.re) + 1.0)) + self.topLine.frame.origin.x,
                               y: self.leftLine.frame.size.height * CGFloat(abs(complex.im)/(abs(complex.im) + 1.0)) - self.leftLine.frame.origin.x)
        } else {
            self.topLine.isHidden = true
            self.leftLine.isHidden = true
            self.rightLine.isHidden = false
            self.bottomLine.isHidden = false
            
            self.leftTopLabel.isHidden = true
            self.leftBottomLabel.isHidden = false
            self.rightBottomLabel.isHidden = false
            self.rightTopLabel.isHidden = false
            
            self.rightTopLabel.text = "\(yScale)"
            self.rightBottomLabel.text = "0.0"
            self.leftBottomLabel.text = "-\(xScale)"
            
            zeroPoint = CGPoint(x: self.rightBottomLabel.frame.origin.x,
                                y: self.rightBottomLabel.frame.origin.y)
            
            endPoint = CGPoint(x: self.topLine.frame.size.width - self.topLine.frame.size.width * CGFloat(abs(complex.re)/(abs(complex.re) + 1.0)) + self.topLine.frame.origin.x,
                               y: self.leftLine.frame.size.height - self.leftLine.frame.size.height * CGFloat(abs(complex.im)/(abs(complex.im) + 1.0)) + self.leftLine.frame.origin.x)
        }
        
        let arrow = UIBezierPath.withArrowFromPoint(startPoint: zeroPoint, endPoint: endPoint, tailWidth: 1.0, headWidth: 16.0, headLength: 16.0)
        
        arrowLayer.strokeColor = UIColor.darkGray.cgColor
        arrowLayer.lineWidth = 1
        arrowLayer.path = arrow.cgPath
        arrowLayer.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(arrowLayer)
    }
}

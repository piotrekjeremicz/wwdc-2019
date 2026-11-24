//
//  BitView.swift
//  Computer Test
//
//  Created by Piotrek on 20/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import UIKit

public class BitView: UIView {

    public let bitLabel = UILabel()
    public let bitNumber = UILabel()
    
    private var didSetupConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.bitLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bitLabel.font = UIFont.systemFont(ofSize: 17.0)
        self.bitLabel.textAlignment = .center
        self.bitLabel.textColor = .black
        self.bitLabel.text = "0"
        
        self.addSubview(self.bitLabel)
        
        self.bitNumber.translatesAutoresizingMaskIntoConstraints = false
        self.bitNumber.font = UIFont.systemFont(ofSize: 9.0)
        self.bitNumber.textAlignment = .center
        self.bitNumber.textColor = .black
        self.bitNumber.text = "B0"
        
        self.addSubview(self.bitNumber)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: .zero)
    }
    
    override public func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
            
            NSLayoutConstraint.activate([
                    self.bitLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 2.0),
                    self.bitLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -2.0),
                    self.bitLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0.0),
                    self.bitLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0),
                    self.bitNumber.rightAnchor.constraint(equalTo: rightAnchor, constant: -2.0),
                    self.bitNumber.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.0),
                    self.bitNumber.heightAnchor.constraint(equalToConstant: 16.0),
                    self.bitNumber.widthAnchor.constraint(equalToConstant: 16.0)]
            )
        }
        super.updateConstraints()
    }
}

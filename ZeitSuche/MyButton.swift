//
//  MyButton.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 27/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit

@IBDesignable

class MyButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.backgroundColor = UIColor(red: 196, green: 39, blue: 91)
            } else {
                self.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.borderColor = UIColor(red: 196, green: 39, blue: 91).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.setTitleColor(UIColor(red: 196, green: 39, blue: 91), for: UIControlState())
    }

}

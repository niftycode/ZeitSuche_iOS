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

    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                self.backgroundColor = UIColor(red: 196, green: 39, blue: 91)
            } else {
                self.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.layer.borderColor = UIColor(red: 196, green: 39, blue: 91).CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.setTitleColor(UIColor(red: 196, green: 39, blue: 91), forState: UIControlState.Normal)
    }

}

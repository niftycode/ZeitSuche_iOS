//
//  MyLabel.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 27/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit

@IBDesignable

class MyLabel: UILabel {
    
    // override drawTextInRect to customize UILabel
    override func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: [NSAttributedStringKey.font: font],
                context: nil).size
            super.drawText(in: CGRect(x: 0, y: 0, width: self.frame.width, height: ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    
    // for InterfaceBuilder visibility
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
 

}

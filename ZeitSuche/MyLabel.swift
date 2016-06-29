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
    override func drawTextInRect(rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRectWithSize(CGSizeMake(CGRectGetWidth(self.frame), CGFloat.max),
                                                                            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                                            attributes: [NSFontAttributeName: font],
                                                                            context: nil).size
            super.drawTextInRect(CGRectMake(0, 0, CGRectGetWidth(self.frame), ceil(labelStringSize.height)))
        } else {
            super.drawTextInRect(rect)
        }
    }
    
    // for InterfaceBuilder visibility
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 1
        layer.borderColor = UIColor.blackColor().CGColor
    }
 

}

//
//  String.swift
//  Events
//
//  Created by Alexey Kostenko on 6/12/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

extension String {
    
    func setAttributes(withFont font: UIFont, textColor color: UIColor, aligment: NSTextAlignment, underlineStyle: NSUnderlineStyle? = nil) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        var myAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        if let uL = underlineStyle {
            myAttribute[NSAttributedString.Key.underlineStyle] = uL.rawValue
        }
        
        let attributedString = NSAttributedString(string: self, attributes: myAttribute)
//        attributedText = attributedString
        
        return attributedString
    }
}

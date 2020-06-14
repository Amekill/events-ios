//
//  UIColor.swift
//  Events
//
//  Created by Alexey Kostenko on 6/7/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
}

//
//  TapticHelper.swift
//  Events
//
//  Created by Alexey Kostenko on 6/17/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

struct TapticHelper {
    
    static func generateImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}

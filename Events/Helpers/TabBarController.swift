//
//  TabBarController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/7/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

//class TabBarController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        delegate = self
//        
//        tabBar.shadowImage = UIImage()
//        tabBar.backgroundImage = UIImage()
//        
//        let font = UIFont(name: "OpenSans-Regular", size: 16)!
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -14)
//        UITabBar.appearance().isTranslucent = false
//        UITabBar.appearance().tintColor = UIColor(r: 255, g: 59, b: 48)
//    }
//}
//
//extension TabBarController: UITabBarControllerDelegate  {
//    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//
//        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
//            return false
//        }
//
//        if fromView != toView {
//          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
//        }
//
//        return true
//    }
//}

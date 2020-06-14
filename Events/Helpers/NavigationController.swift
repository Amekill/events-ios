//
//  NavigationController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/7/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

//class NavigationController: UINavigationController {
//    
//    var navBar: NavigationBar?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setNavigationBarHidden(true, animated: false)
//        
//        navBar = NavigationBar()
//        view.addSubview(navBar!)
//    }
//}
//
//class NavigationBar: UIView {
//    
//    private let screen = UIScreen.main.bounds.size
//    private let statusBar = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size ?? CGSize(width: 0, height: 0)
//    
//    let titleLabel = UILabel()
//    let rightButton = UIButton(type: .system)
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        drawBar()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        drawBar()
//    }
//    
//    private func drawBar() {
//        titleLabel.frame = CGRect(x: 25, y: 57, width: screen.width - 50, height: 30)
//        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 21)
//        addSubview(titleLabel)
//        
//        rightButton.frame = CGRect(x: screen.width - 18 - 30, y: 57, width: 30, height: 30)
//        addSubview(rightButton)
//        
//        frame = CGRect(x: 0, y: 0, width: screen.width, height: statusBar.height + 56)
//        backgroundColor = .white
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        layer.shadowRadius = 10
//        layer.shadowColor = UIColor.black.withAlphaComponent(0.10).cgColor
//        layer.shadowOpacity = 1.0
//    }
//}

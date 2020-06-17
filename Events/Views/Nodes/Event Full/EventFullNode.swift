//
//  EventFullNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/17/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class EventFullNode: ASDisplayNode {
    
    private let indicator = ASImageNode()
    private let name = ASTextNode()
    private let time = ASTextNode()
    private let date = ASTextNode()
    
    override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
//        backgroundColor = .red
        set()
    }
    
    override func didLoad() {
        super.didLoad()
        
        indicator.image = UIImage(named: "i_arrow_down")
        indicator.imageModificationBlock = ASImageNodeTintColorModificationBlock(.green)
    }
    
    func set() {
        time.attributedText = "Today".setAttributes(
            withFont: UIFont(name: "OpenSans-SemiBold", size: 32)!, textColor: .white, aligment: .left
        )
        
        name.attributedText = "Event Name".setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 17)!, textColor: .white, aligment: .left
        )
        
        date.attributedText = "December 31, 2018".uppercased().setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 12)!, textColor: UIColor.white.withAlphaComponent(0.75), aligment: .left
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        indicator.style.preferredSize = CGSize(width: 24, height: 24)
        
        let timeStack = ASStackLayoutSpec(
            direction: .horizontal, spacing: 2, justifyContent: .start, alignItems: .center,
            children: [indicator, time]
        )
        
        let content = ASStackLayoutSpec(
            direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch,
            children: [timeStack, name, date]
        )
        
        let insets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 16, bottom: .infinity, right: 16), child: content
        )
        
        return insets
    }
}

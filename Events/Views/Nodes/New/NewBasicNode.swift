//
//  NewBasicNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/15/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class NewBasicNode: TableCell {
    
    private let titleNode = ASTextNode()
    private let accessoryIndicator = ASImageNode()
    private let separator = ASDisplayNode()
    
    override func didLoad() {
        super.didLoad()
        
        accessoryIndicator.image = UIImage(named: "i_checkmark")
        accessoryIndicator.imageModificationBlock = ASImageNodeTintColorModificationBlock(Constants.accent_color)
        separator.backgroundColor = Constants.separator_color
    }
    
    func set(title: String) {
        titleNode.attributedText = title.setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 17)!, textColor: .black, aligment: .left
        )
    }
    
    func hideAccessoryIndicator() {
        accessoryIndicator.isHidden = true
    }
    
    func showAccessoryIndicator() {
        accessoryIndicator.isHidden = false
    }
    
    func hideSeparator() {
        separator.isHidden = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        accessoryIndicator.style.preferredSize = CGSize(width: 24, height: 24)
        
        separator.style.preferredSize = CGSize(width: 400, height: 0.5)
        separator.style.layoutPosition.x = 12
        
        let body = ASStackLayoutSpec(
            direction: .horizontal, spacing: 12, justifyContent: .spaceBetween, alignItems: .center,
            children: [titleNode, accessoryIndicator]
        )
        
        let bodyInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12), child: body
        )
                
        let separatorElement = ASAbsoluteLayoutSpec(children: [separator])
        
        let content = ASStackLayoutSpec(
            direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch,
            children: separator.isHidden ? [bodyInsets] : [bodyInsets, separatorElement]
        )
        
        let backgroundSpec = ASBackgroundLayoutSpec(
            child: content, background: background
        )
        
        let backgroundInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12), child: backgroundSpec
        )
        
        return backgroundInsets
    }
}

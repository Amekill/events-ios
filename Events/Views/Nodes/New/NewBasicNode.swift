//
//  NewBasicNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class NewBasicNode: TableCell {
    
    private let titleNode = ASTextNode()
    private let subtitleNode = ASTextNode()
    private let indicator = ASImageNode()
    private let separator = ASDisplayNode()
    
    override func didLoad() {
        super.didLoad()
        
        indicator.image = UIImage(named: "i_arrow_right")
        separator.backgroundColor = Constants.separator_color
    }
    
    func setNode(title: String, subtitle: String) {
        titleNode.attributedText = title.setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 17)!, textColor: .black, aligment: .left
        )
        
        subtitleNode.attributedText = subtitle.setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 16)!, textColor: Constants.text_placeholder_color, aligment: .left
        )
    }
    
    func hideSeparator() {
        separator.isHidden = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        indicator.style.width = ASDimension(unit: .points, value: 24)
        indicator.style.height = ASDimension(unit: .points, value: 24)
        
        separator.style.preferredSize = CGSize(width: 400, height: 0.5)
        separator.style.layoutPosition.x = 12
        
        let labesStack = ASStackLayoutSpec(
            direction: .vertical, spacing: 6, justifyContent: .start, alignItems: .stretch,
            children: [titleNode, subtitleNode]
        )
        
        labesStack.style.flexShrink = 1.0
        labesStack.style.flexGrow = 1.0
        
        let body = ASStackLayoutSpec(
            direction: .horizontal, spacing: 5, justifyContent: .spaceBetween, alignItems: .center,
            children: [labesStack, indicator]
        )
        
        body.style.minHeight = ASDimension(unit: .points, value: 34)
        
        let bodyInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12), child: body
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

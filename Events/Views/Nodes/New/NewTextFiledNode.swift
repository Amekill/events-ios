//
//  NewTextFiledNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class NewTextFiledNode: TableCell {
    
    private let titleNode = ASTextNode()
    let textFieldNode = ASEditableTextNode()
    private let separator = ASDisplayNode()
    
    func set(title: String, value: String) {
        titleNode.attributedText = title.setAttributes(
            withFont: UIFont(name: "OpenSans-SemiBold", size: 17)!, textColor: .black, aligment: .left
        )
        
        textFieldNode.attributedText = value.setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 16)!, textColor: .black, aligment: .left
        )
        
        textFieldNode.attributedPlaceholderText = "Enter".setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 16)!, textColor: Constants.text_placeholder_color, aligment: .left
        )
    }
    
    override func didLoad() {
        super.didLoad()
        
        textFieldNode.tintColor = Constants.accent_color
        textFieldNode.textView.font = UIFont(name: "OpenSans-Regular", size: 16)!
        separator.backgroundColor = Constants.separator_color
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        separator.style.preferredSize = CGSize(width: 400, height: 0.5)
        separator.style.layoutPosition.x = 12
        
        textFieldNode.style.minHeight = ASDimension(unit: .points, value: 24)
        
        let body = ASStackLayoutSpec(
            direction: .vertical, spacing: 6, justifyContent: .start, alignItems: .stretch,
            children: [titleNode, textFieldNode]
        )
        
        body.style.flexShrink = 1.0
        body.style.flexGrow = 1.0
        
        let bodyInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12), child: body
        )
        
        let content = ASStackLayoutSpec(
            direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch,
            children: [bodyInsets, ASAbsoluteLayoutSpec(children: [separator])]
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

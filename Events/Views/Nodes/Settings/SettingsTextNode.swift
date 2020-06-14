//
//  SettingsTextNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/12/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class SettingsTextNode: TableCell {
    
    private let imageNode = ASImageNode()
    private let titleNode = ASTextNode()
    private let accessoryIndicator = ASImageNode()
    let separator = ASDisplayNode()

    func set(image: String, title: String) {
        imageNode.image = UIImage(named: image)
        
        titleNode.attributedText = title.setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 17)!,
            textColor: .black, aligment: .left
        )
    }
    
    override func didLoad() {
        super.didLoad()
        
        accessoryIndicator.image = UIImage(named: "i_arrow_right")
        separator.backgroundColor = Constants.separator_color
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: 24, height: 24)
        accessoryIndicator.style.preferredSize = CGSize(width: 24, height: 24)
        separator.style.preferredSize = CGSize(width: 400, height: 0.5)
        separator.style.layoutPosition.x = 24 + 12 + 12
        
        let stack = ASStackLayoutSpec(
            direction: .horizontal, spacing: 12, justifyContent: .start, alignItems: .center,
            children: [imageNode, titleNode]
        )
        
        let cell = ASStackLayoutSpec(
            direction: .horizontal, spacing: 12, justifyContent: .spaceBetween, alignItems: .center,
            children: [stack, accessoryIndicator]
        )
        
        cell.style.minHeight = ASDimension(unit: .points, value: 34)
        
        let insets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 8),
            child: cell
        )
        
        let content = ASStackLayoutSpec(
            direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch,
            children: [insets, ASAbsoluteLayoutSpec(children: [separator])]
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

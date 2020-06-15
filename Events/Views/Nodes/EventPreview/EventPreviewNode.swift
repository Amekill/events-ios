//
//  EventPreviewNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/12/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class EventPreviewNode: TableCell {
    
    private let imageShadow = ASDisplayNode()
    private let image = ASImageNode()
    
    private let titleShadow = ASImageNode()
    private let titleNode = ASTextNode()
    private let timeNode = ASTextNode()
    
    override init() {
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        
        image.contentMode = .scaleAspectFill
        image.cornerRadius = 5
        
        imageShadow.cornerRadius = 5
        imageShadow.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        imageShadow.shadowOffset = CGSize(width: 0, height: 0)
        imageShadow.shadowRadius = 3
        imageShadow.shadowOpacity = 1
        imageShadow.backgroundColor = .white
        
        titleShadow.image = UIImage(named: "shadow")
        titleShadow.contentMode = .scaleAspectFill
    }
    
    func setNode(name: String, days: String, bg: UIImage?) {
        image.backgroundColor = .white
        image.image = bg
        
        titleNode.attributedText = name.setAttributes(
            withFont: UIFont(name: "OpenSans-Semibold", size: 20)!, textColor: .white, aligment: .left
        )
        
        timeNode.attributedText = days.setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 16)!, textColor: .white, aligment: .left
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        image.style.height = ASDimension(unit: .points, value: 165)
        
        titleShadow.style.preferredSize = CGSize(width: constrainedSize.max.width - 32, height: 83)
        titleShadow.style.layoutPosition = CGPoint(x: 0, y: 82)
        
        let labelsStack = ASStackLayoutSpec(
            direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .stretch,
            children: [titleNode, timeNode]
        )
        
        let labelsInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: .infinity, left: 14, bottom: 18, right: 14), child: labelsStack
        )
        
        let imageContent = ASBackgroundLayoutSpec(child: image, background: imageShadow)
        let titleShadowContent = ASBackgroundLayoutSpec(
            child: ASAbsoluteLayoutSpec(children: [titleShadow]), background: imageContent
        )
        
        let content = ASOverlayLayoutSpec(child: titleShadowContent, overlay: labelsInsets)
        
        let insets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16), child: content
        )
        
        return insets
    }
}

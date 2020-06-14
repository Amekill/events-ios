//
//  NewImageNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class NewImageNode: TableCell {
    
    private let titleNode = ASTextNode()
    private let indicator = ASImageNode()
    private let imagePreview = ASImageNode()
    private let imageShadow = ASImageNode()
    private let imageTitle = ASTextNode()
    
    override func didLoad() {
        super.didLoad()
        
        indicator.image = UIImage(named: "i_arrow_right")
        imagePreview.contentMode = .scaleAspectFill
        imagePreview.cornerRadius = 5
        
        imageTitle.attributedText = "Current background".setAttributes(
            withFont: UIFont(name: "OpenSans-Bold", size: 15)!, textColor: .white, aligment: .left
        )
        
        imageShadow.image = UIImage(named: "shadow")
        imageShadow.view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    func setNode(title: String) {
        imagePreview.image = UIImage(named: "2")
        
        titleNode.attributedText = title.setAttributes(
            withFont: UIFont(name: "OpenSans-Regular", size: 17)!, textColor: .black, aligment: .left
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        indicator.style.width = ASDimension(unit: .points, value: 24)
        indicator.style.height = ASDimension(unit: .points, value: 24)
        imagePreview.style.height = ASDimension(unit: .points, value: 165)
        imageShadow.style.height = ASDimension(unit: .points, value: 83)
        imageTitle.style.layoutPosition = CGPoint(x: 8, y: 6)
        
        let body = ASStackLayoutSpec(
            direction: .horizontal, spacing: 5, justifyContent: .spaceBetween, alignItems: .center,
            children: [titleNode, indicator]
        )
        
        body.style.minHeight = ASDimension(unit: .points, value: 34)
        
        let iTitle = ASAbsoluteLayoutSpec(children: [imageTitle])
        let imageShadowObject = ASWrapperLayoutSpec(layoutElements: [imagePreview, imageShadow, iTitle])
                
        let content = ASStackLayoutSpec(
            direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .stretch,
            children: [body, imageShadowObject]
        )
        
        let contentInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12), child: content
        )
        
        let backgroundSpec = ASBackgroundLayoutSpec(
            child: contentInsets, background: background
        )
        
        let backgroundInsets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12), child: backgroundSpec
        )
        
        return backgroundInsets
    }
}

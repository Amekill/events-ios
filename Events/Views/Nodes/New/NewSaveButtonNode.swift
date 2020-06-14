//
//  NewSaveButtonNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class NewSaveButtonNode: TableCell {
    
    let saveButtonNode = ASButtonNode()
    
    override func didLoad() {
        super.didLoad()
        
        saveButtonNode.setTitle(
            "Create Event", with: UIFont(name: "OpenSans-SemiBold", size: 17), with: .white, for: .normal
        )
        
        saveButtonNode.backgroundColor = Constants.accent_color
        saveButtonNode.contentEdgeInsets.left = 35
        saveButtonNode.contentEdgeInsets.right = 35
        saveButtonNode.cornerRadius = 22
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        saveButtonNode.style.preferredSize = CGSize(width: 150, height: 44)
        saveButtonNode.style.height = ASDimension(unit: .points, value: 44)
        
        let button = ASStackLayoutSpec(
            direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .stretch,
            children: [saveButtonNode]
        )
        
        let insets = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16), child: button
        )
        
        return insets
    }
}

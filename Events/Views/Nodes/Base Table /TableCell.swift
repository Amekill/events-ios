//
//  TableCell.swift
//  Events
//
//  Created by Alexey Kostenko on 6/12/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class TableCell: ASCellNode {
    
    let background = ASDisplayNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        
        background.backgroundColor = .white
        
        background.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        background.layer.shadowOffset = CGSize.zero
        background.layer.shadowOpacity = 1
        background.layer.cornerRadius = 1
    }
}

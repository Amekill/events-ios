//
//  NewEventController + ASEditableTextNode.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

// MARK: - ASEditableTextNode: Delegate

extension NewEventController: ASEditableTextNodeDelegate {
    
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            editableTextNode.resignFirstResponder()
        }
        
        return true
    }
    
    func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
        eventModel.name = editableTextNode.textView.text
    }
}

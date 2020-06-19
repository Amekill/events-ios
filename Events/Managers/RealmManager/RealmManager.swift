//
//  RealmManager.swift
//  Events
//
//  Created by Alexey Kostenko on 6/18/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import Foundation

class RealmManager: NSObject {
    
    static let shared = RealmManager()
    
    private override init() {
        event = RLMEvent()
        
        super.init()
    }
    
    let event: RLMEvent
}

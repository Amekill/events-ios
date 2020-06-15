//
//  DataManager.swift
//  Events
//
//  Created by Alexey Kostenko on 6/15/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    static let shared = DataManager()
    
    private override init() {
        
        events = DataManagerObject<EventModel>()
        
        super.init()
    }
    
    let events: DataManagerObject<EventModel>
}

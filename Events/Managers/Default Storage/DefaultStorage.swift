//
//  DefaultStorage.swift
//  Events
//
//  Created by Alexey Kostenko on 6/16/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import Foundation

class DefaultStorage {
    
    static let shared = DefaultStorage()
    private let df = UserDefaults()
    
    func save(data: Any, forKey key: Key) {
        df.set(data, forKey: key.rawValue)
    }
    
    func get(forKey key: Key) -> String? {
        return df.string(forKey: key.rawValue)
    }
    
    func remove(forKey key: Key) {
        df.removeObject(forKey: key.rawValue)
    }
    
    enum Key: String {
        case firstLaunch
        case sortedBy
    }
}

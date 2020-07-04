//
//  DataManagerObject.swift
//  Events
//
//  Created by Alexey Kostenko on 6/15/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

class DataManagerObject<T> {
    
    var array: [T]
    
    init() {
        array = []
    }
    
    func saveNewArray(_ array: [T]) {
        self.array = array
    }
    
    func clear() {
        array.removeAll()
    }
}

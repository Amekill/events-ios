//
//  EventModel.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit
import RealmSwift

class EventModel {
    
    var id: Int?
    var name: String?
    var category: NewEventCategory?
    var date: Date?
    var image: UIImage?
    var notifications: NewEventNotificationsRepeat?
    var dateFormat: EventDateFormat = .days
}

class RLMEventModel: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var category = ""
    @objc dynamic var date = Date()
    @objc dynamic var image = ""
    @objc dynamic var notifications = ""
    @objc dynamic var dateFormat = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, name: String, category: NewEventCategory, date: Date, image: String, notifications: NewEventNotificationsRepeat, dateFormat: EventDateFormat) {
        self.init()
        
        self.id = id
        self.name = name
        self.category = category.rawValue
        self.date = date
        self.image = image
        self.notifications = notifications.rawValue
        self.dateFormat = dateFormat.rawValue
    }
    
    required init() {
        super.init()
    }
}

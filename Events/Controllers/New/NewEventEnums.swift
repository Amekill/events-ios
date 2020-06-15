//
//  NewEventEnums.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import Foundation

enum NewEventContentType: String {
    
    case name = "Name"
    case category = "Category"
    case date = "Date"
    case image = "Image"
    case notifications = "Notifications"
    case create
}

enum NewEventCategory: String {
    
    case business = "Business"
    case travel = "Travel"
    case birthday = "Birthday"
    case wedding = "Wedding"
    case other = "Other"
    case createdByUser
}

enum NewEventNotificationsRepeat: String {
    
    case never = "Never"
    case everyWeek = "Every Week"
    case everyMonth = "Every Month"
    case everyYear = "Every Year"
}

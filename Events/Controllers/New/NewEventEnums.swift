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
    
    case business
    case travel
    case birthday
    case wedding
    case other
    case createdByUser
    
    var title: String {
        switch self {
        case .business:
            return "Business"
        case .travel:
            return "Travel"
        case .birthday:
            return "Birthday"
        case .wedding:
            return "Wedding"
        case .other:
            return "Other"
        default:
            return ""
        }
    }
}

enum NewEventNotificationsRepeat: String {
    
    case never
    case everyWeek
    case everyMonth
    case everyYear
    
    var title: String {
        switch self {
        case .never:
            return "Never"
        case .everyWeek:
            return "Every Week"
        case .everyMonth:
            return "Every Month"
        case .everyYear:
            return "Every Year"
        }
    }
}

//
//  NotificationManager.swift
//  Events
//
//  Created by Alexey Kostenko on 6/21/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationManager {

    static func add(event: EventModel) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if error == nil && success {

            } else {

            }
        }
        
        let date = event.date ?? Date()

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 0
        
        switch event.notifications {
        case .everyWeek:
            dateComponents.weekday = Calendar.current.dateComponents([.weekday], from: date).weekday
        case .everyMonth:
            dateComponents.day = Calendar.current.dateComponents([.day], from: date).day
            dateComponents.weekOfMonth = Calendar.current.dateComponents([.weekOfMonth], from: date).weekOfMonth
        case .everyYear:
            dateComponents.day = Calendar.current.dateComponents([.day], from: date).day
            dateComponents.month = Calendar.current.dateComponents([.month], from: date).month
        default:
            break
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let c = UNMutableNotificationContent()
        c.title = event.name ?? ""
        c.body = "Don't forget about this event!"
        c.sound = .default
        
        let notification = UNNotificationRequest(identifier: "\(event.id ?? 0)", content: c, trigger: trigger)
        UNUserNotificationCenter.current().add(notification, withCompletionHandler: { _ in })
    }
    
    static func delete(eventId: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [eventId])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [eventId])
    }
}

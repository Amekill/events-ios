//
//  DateHelper.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import Foundation

struct DateHelper {
    
    static func formatDate(_ date: Date, format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        
        return df.string(from: date)
    }
    
    private enum DateComponent {
        case day
        case hour
        case minute
        case second
    }
    
    private static func decline(count: Int, component: DateComponent) -> String {
        if count == 0 {
            switch component {
            case .day:
                return "days"
            case .hour:
                return "hours"
            case .minute:
                return "minutes"
            case .second:
                return "seconds"
            }
        } else if (count % 10 == 1 && count % 100 != 11) {
            switch component {
            case .day:
                return "day"
            case .hour:
                return "hour"
            case .minute:
                return "minute"
            case .second:
                return "second"
            }
        } else if ((count % 10 >= 2 && count % 10 <= 4) && !(count % 100 >= 12 && count % 100 <= 14)) {
            switch component {
            case .day:
                return "days"
            case .hour:
                return "hours"
            case .minute:
                return "minutes"
            case .second:
                return "seconds"
            }
        } else if (count % 10 == 0 || (count % 10 >= 5 && count % 10 <= 9) || (count % 100 >= 11 && count % 100 <= 14)) {
            switch component {
            case .day:
                return "days"
            case .hour:
                return "hours"
            case .minute:
                return "minutes"
            case .second:
                return "seconds"
            }
        }
        
        return ""
    }
    
    static func formatDateToPreviewString(_ date: Date) -> String {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date2, to: date1)
        let days = abs(components.day ?? 0)
        
        var dString: String {
//            let hours = abs(components.hour ?? 0)
//            let minute = abs(components.minute ?? 0)
//            let seconds = abs(components.second ?? 0)
//
//            if days == 0 {
//                if hours == 0 {
//                    if minute == 0 {
//                        return "\(seconds) \(decline(count: seconds, component: .second))"
//                    }
//
//                    return "\(minute) \(decline(count: minute, component: .minute)) \(seconds) \(decline(count: seconds, component: .second))"
//                }
//
//                return "\(hours) \(decline(count: hours, component: .hour)) \(minute) \(decline(count: minute, component: .minute))"
//            }
//
//            return "\(days) \(decline(count: days, component: .day))"
            return "\(days) \(decline(count: days, component: .day))"
        }
        
        if days == 0 {
            return "Today"
        }
        
        if date >= Date() {
            return "In \(dString)"
        } else {
            return "\(dString) ago"
        }
    }
}

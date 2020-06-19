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
        case year
        case month
        case week
        case day
        case hour
        case minute
        case second
    }
    
    private static func decline(count: Int, component: DateComponent) -> String {
        switch component {
        case .year:
            return "y"
        case .month:
            return "m"
        case .week:
            return "w"
        case .day:
            return "d"
        case .hour:
            return "h"
        case .minute:
            return "min"
        case .second:
            return "sec"
        }
    }
//        if count == 0 {
//            switch component {
//            case .year:
//                return "y"
//            case .month:
//                return "m"
//            case .week:
//                return "w"
//            case .day:
//                return "d"
//            case .hour:
//                return "h"
//            case .minute:
//                return "min"
//            case .second:
//                return "sec"
//            }
//        } else if (count % 10 == 1 && count % 100 != 11) {
//            switch component {
//            case .month:
//                return "m"
//            case .week:
//                return "week"
//            case .day:
//                return "day"
//            case .hour:
//                return "hour"
//            case .minute:
//                return "minute"
//            case .second:
//                return "second"
//            }
//        } else if ((count % 10 >= 2 && count % 10 <= 4) && !(count % 100 >= 12 && count % 100 <= 14)) {
//            switch component {
//            case .month:
//                return "m"
//            case .week:
//                return "weeks"
//            case .day:
//                return "days"
//            case .hour:
//                return "hours"
//            case .minute:
//                return "minutes"
//            case .second:
//                return "seconds"
//            }
//        } else if (count % 10 == 0 || (count % 10 >= 5 && count % 10 <= 9) || (count % 100 >= 11 && count % 100 <= 14)) {
//            switch component {
//            case .month:
//                return "m"
//            case .week:
//                return "weeks"
//            case .day:
//                return "days"
//            case .hour:
//                return "hours"
//            case .minute:
//                return "minutes"
//            case .second:
//                return "seconds"
//            }
//        }
//
//        return ""
//    }
    
    static func format(date: Date, style: EventDateFormat) -> String {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: Date())
        
        switch style {
        case .days:
            let components = calendar.dateComponents([.day], from: date2, to: date1)
            let days = abs(components.day ?? 0)
            
            if days == 0 {
                return "Today"
            }
            
            let s = "\(days) \(decline(count: days, component: .day))"
            return date >= Date() ? ("In " + s) : (s + " ago")
        case .weeksDays:
            let components = calendar.dateComponents([.day, .weekOfYear], from: date2, to: date1)
            let weeks = abs(components.weekOfYear ?? 0)
            let days = abs(components.day ?? 0)
            
            let s = "\(weeks) \(decline(count: weeks, component: .week)) \(days) \(decline(count: days, component: .day))"
            return date >= Date() ? ("In " + s) : (s + " ago")
        case .monthsWeeks:
            let components = calendar.dateComponents([.month, .weekOfYear], from: date2, to: date1)
            let months = abs(components.month ?? 0)
            let weeks = abs(components.weekOfYear ?? 0)
            
            let s = "\(months) \(decline(count: months, component: .month)) \(weeks) \(decline(count: weeks, component: .week))"
            return date >= Date() ? ("In " + s) : (s + " ago")
        case .monthsDays:
            let components = calendar.dateComponents([.month, .day], from: date2, to: date1)
            let months = abs(components.month ?? 0)
            let days = abs(components.day ?? 0)
            
            let s = "\(months) \(decline(count: months, component: .month)) \(days) \(decline(count: days, component: .day))"
            return date >= Date() ? ("In " + s) : (s + " ago")
        case .yearsMonths:
            let components = calendar.dateComponents([.year, .month], from: date2, to: date1)
            let year = abs(components.year ?? 0)
            let month = abs(components.month ?? 0)
            
            let s = "\(year) \(decline(count: year, component: .year)) \(month) \(decline(count: month, component: .month))"
            return date >= Date() ? ("In " + s) : (s + " ago")
        }
    }
    
    static func formatDateToPreviewString(_ date: Date) -> String {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date2, to: date1)
        let days = abs(components.day ?? 0)
        
        if days == 0 {
            return "Today"
        }
        
        let dString = "\(days) \(decline(count: days, component: .day))"
        
        if date >= Date() {
            return "In \(dString)"
        } else {
            return "\(dString) ago"
        }
    }
}

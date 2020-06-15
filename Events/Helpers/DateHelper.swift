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
    
    static func formatDateToPreviewString(_ date: Date) -> String {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date2, to: date1)
        
        if date >= Date() {
            return "In \(components.day ?? 0) days"
        } else {
            return "\(-(components.day ?? 0)) days ago"
        }
    }
}

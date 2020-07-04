//
//  SettingsEnums.swift
//  Events
//
//  Created by Alexey Kostenko on 6/12/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import Foundation

enum SettingsContentType: String {
    
    case sortBy = "Sorted by"
    case appearance = "Appearance"
    case backup = "iCloud Backup"
    case about = "About App"
    case pro = "Pro version"
    case rateApp = "Rate app"
    case share = "Share Events"
    
    enum SortType: String {
        case date
        case last
        
        var title: String {
            switch self {
            case .date:
                return "Date"
            case .last:
                return "Last"
            }
        }
    }
}

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
        case date = "Date"
        case last = "Last"
    }
    
//    var image: String {
//        switch self {
//        case .sortBy:
//            return "i_sort"
//        case .appearance:
//            return "i_appearance"
//        case .backup:
//            return "i_backup"
//        case.about:
//            return "i_info"
//        case .pro:
//            return "i_upgrade"
//        }
//    }
}

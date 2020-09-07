//
//  EventRowController.swift
//  Events Watch Extension
//
//  Created by Alexey Kostenko on 4.07.20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import WatchKit

class EventRowController: NSObject {
    
    @IBOutlet var name: WKInterfaceLabel!
    @IBOutlet var date: WKInterfaceLabel!
    @IBOutlet var indicator: WKInterfaceImage!
}

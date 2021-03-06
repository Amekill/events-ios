//
//  InterfaceController.swift
//  Events Watch Extension
//
//  Created by Alexey Kostenko on 4.07.20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setTable()
    }
    
    private func setTable() {
        table.setNumberOfRows(5, withRowType: "EventRowController")
        
        for i in 0...3 {
            let row = table.rowController(at: i) as! EventRowController
            row.date.setText("\(i)")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

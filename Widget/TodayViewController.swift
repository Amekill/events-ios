//
//  TodayViewController.swift
//  Widget
//
//  Created by Alexey Kostenko on 6/22/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit
import NotificationCenter
import RealmSwift

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet private var tableView: UITableView!
    
    private var content: [EventModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.events.database")!
            .appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: fileURL)
        let realm = try? Realm(configuration: config)
        
        let events = realm?.objects(RLMEventModel.self)
        
        if let events = events {
            content.removeAll(keepingCapacity: true)
                        
            for e in events {
                content.append(rlmToLocal(e))
            }
        }
        
        setupTableView()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func rlmToLocal(_ e: RLMEventModel) -> EventModel {
        let event = EventModel()
        event.id = e.id
        event.name = e.name
        event.category = NewEventCategory(rawValue: e.category)
        event.date = e.date
        event.image = ImageHelper.loadImageFromDocumentDirectory(fileName: e.image)
        event.notifications = NewEventNotificationsRepeat(rawValue: e.notifications)
        event.dateFormat = EventDateFormat(rawValue: e.dateFormat) ?? .days
        
        return event
    }
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WidgetCell
        cell.selectionStyle = .none
        let c = content[indexPath.row]
        
        cell.title.text = c.name
        let eventDate = c.date ?? Date()
        cell.date.text = DateHelper.formatDateToPreviewString(eventDate)
        cell.indicator.image = UIImage(named: eventDate > Date() ? "i_arrow_down" : "i_arrow_up")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
}

//
//  NewEventNotificationsController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/15/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class NewEventNotificationsController: TableNodeController {
    
    var eventModel: EventModel?
    
    private var content: [Int: [NewEventNotificationsRepeat]] = [
        0: [
            .never, .everyWeek, .everyMonth, .everyYear
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        view.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        title = "Notifications"
        tableNode.view.separatorStyle = .none
    }
    
    // MARK: - TableNode: Delegate
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return content.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return content[section]?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let c = content[indexPath.section]![indexPath.row]
        let node = NewBasicNode()
        node.set(title: c.rawValue)
        
        if c != eventModel?.notifications {
            node.hideAccessoryIndicator()
        }
        
        if (content[indexPath.section]!.count - 1) == indexPath.row {
            node.hideSeparator()
        }
        
        return node
    }
    
    // MARK: - TableNode: Header & Footer
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        let s = UIView()
        
        s.frame = CGRect(x: 12, y: 10, width: UIScreen.main.bounds.size.width - 24, height: 20)
        s.backgroundColor = .white
        s.layer.shadowRadius = 4
        s.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        s.layer.shadowOffset = CGSize.zero
        s.layer.shadowOpacity = 1
        s.layer.cornerRadius = 5
        
        v.addSubview(s)
        v.clipsToBounds = true
        
        return v
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        let s = UIView()
        
        s.frame = CGRect(x: 12, y: -16, width: UIScreen.main.bounds.size.width - 24, height: 20)
        s.backgroundColor = .white
        s.layer.shadowRadius = 4
        s.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        s.layer.shadowOffset = CGSize.zero
        s.layer.shadowOpacity = 1
        s.layer.cornerRadius = 5
        
        v.addSubview(s)
        v.clipsToBounds = true
        
        return v
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let c = content[indexPath.section]![indexPath.row]
        eventModel?.notifications = c
        if let node = tableNode.nodeForRow(at: indexPath) as? NewBasicNode {
            node.showAccessoryIndicator()
        }
        
        navigationController?.popViewController(animated: true)
    }
}

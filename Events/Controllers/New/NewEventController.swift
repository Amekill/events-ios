//
//  NewEventController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class NewEventController: TableNodeController {
    
    private let content: [Int: [NewEventContentType]] = [
        0: [
            .name, .category, .date
        ],
        1: [
            .image
        ],
        2: [
            .notification
        ],
        3: [
            .create
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        
        view.backgroundColor = UIColor(r: 248, g: 248, b: 248)
        
        navBar.shadowImage = UIImage()
        navBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.10).cgColor
        navBar.layer.shadowOpacity = 1
        navBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navBar.layer.shadowRadius = 10
        
        navBar.prefersLargeTitles = true
        navBar.topItem?.title = "New Event"
        navBar.tintColor = .black
        
        navBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "OpenSans-SemiBold", size: 17)!
        ]
        
        navBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "OpenSans-SemiBold", size: 30)!
        ]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "i_close"), style: .plain, target: self, action: #selector(dismissController)
        )
        
        navigationItem.largeTitleDisplayMode = .automatic
        
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
        
        switch c {
        case .name:
            let node = NewTextFiledNode()
            node.set(title: c.rawValue, value: "")
            
            return node
        case .category:
            let node = NewBasicNode()
            node.setNode(title: c.rawValue, subtitle: "Select")
            
            return node
        case .date:
            let node = NewBasicNode()
            node.setNode(title: c.rawValue, subtitle: "Select")
            node.hideSeparator()
            
            return node
        case .image:
            let node = NewImageNode()
            node.setNode(title: c.rawValue)
            
            return node
        case .notification:
            let node = NewBasicNode()
            node.setNode(title: c.rawValue, subtitle: "Select")
            node.hideSeparator()
            
            return node
        case .create:
            let node = NewSaveButtonNode()
            
            return node
        }
    }
    
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
        
        if (content.count - 1) == section {
            v.isHidden = true
        }
        
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
        
        if (content.count - 1) == section {
            v.isHidden = true
        }
        
        return v
    }
    
    // MARK: - Actions
    
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

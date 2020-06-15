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
            .notifications
        ],
        3: [
            .create
        ]
    ]
    
    let eventModel = EventModel()
    var imagePicker: ImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // update row's content
        
        if let catNode = tableNode.nodeForRow(at: IndexPath(row: 1, section: 0)) as? NewSelectionNode {
            catNode.setNode(title: "Category", subtitle: eventModel.category?.rawValue)
        }
        
        if let imageNode = tableNode.nodeForRow(at: IndexPath(row: 0, section: 1)) as? NewImageNode {
            imageNode.setNode(title: "Image", image: eventModel.image)
        }
        
        if let notifNode = tableNode.nodeForRow(at: IndexPath(row: 0, section: 2)) as? NewSelectionNode {
            notifNode.setNode(title: "Notifications", subtitle: eventModel.notifications?.rawValue)
        }
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
        title = "New Event"
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
        tableNode.view.keyboardDismissMode = .onDrag
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
            node.textFieldNode.delegate = self
            node.textFieldNode.returnKeyType = .done
            
            return node
        case .category:
            let node = NewSelectionNode()
            node.setNode(title: c.rawValue)
            
            return node
        case .date:
            let node = NewSelectionNode()
            node.setNode(title: c.rawValue)
            node.hideSeparator()
            
            return node
        case .image:
            let node = NewImageNode()
            node.setNode(title: c.rawValue, image: eventModel.image)
            
            return node
        case .notifications:
            let node = NewSelectionNode()
            node.setNode(title: c.rawValue)
            node.hideSeparator()
            
            return node
        case .create:
            let node = NewSaveButtonNode()
            node.saveButtonNode.addTarget(self, action: #selector(createEvent), forControlEvents: .touchUpInside)
            
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
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        
        let c = content[indexPath.section]![indexPath.row]
        
        switch c {
        case .category:
            let c = NewEventSelectCategoryController(withTableStyle: .grouped)
            c.eventModel = eventModel
            
            navigationController?.pushViewController(c, animated: true)
        case .date:
            showDatePicker()
        case .image:
            showAlertWithSelectingImageSource()
        case .notifications:
            let c = NewEventNotificationsController(withTableStyle: .grouped)
            c.eventModel = eventModel
            
            navigationController?.pushViewController(c, animated: true)
        default:
            break
        }
    }
}

//
//  EventsController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/11/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class EventsController: TableNodeController {
    
    private var content: [EventModel] {
        return DataManager.shared.events.array
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if content.isEmpty { setEmptyView()  } else { removeEmptyView() }
        reloadTableNode()
    }
    
    private func updateUI() {
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        
        view.backgroundColor = Constants.background_color
        
        navBar.shadowImage = UIImage()
        navBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.10).cgColor
        navBar.layer.shadowOpacity = 1
        navBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navBar.layer.shadowRadius = 10
        
        navBar.prefersLargeTitles = true
        navBar.topItem?.title = "All Events"
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
            image: UIImage(named: "i_settings"), style: .plain, target: self, action: #selector(openSettings)
        )
        
        navigationItem.largeTitleDisplayMode = .automatic

        let toolBar = UIToolbar()
        toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolBar.backgroundColor = Constants.background_color
        
        let v = UIButton(type: .system)
        v.setTitle("New Event", for: .normal)
        v.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 18)
        v.setTitleColor(Constants.accent_color, for: .normal)
        v.titleEdgeInsets.bottom = 2
        v.tintColor = Constants.accent_color
        v.setImage(UIImage(named:"i_new"), for: .normal)
        v.titleEdgeInsets.left = 5
        v.contentHorizontalAlignment = .left
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(newEvent), for: .touchUpInside)
        
        toolBar.addSubview(v)
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolBar)
        
        let guide = self.view.safeAreaLayoutGuide
        
        toolBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        v.centerYAnchor.constraint(equalTo: toolBar.centerYAnchor).isActive = true
        v.leftAnchor.constraint(equalTo: toolBar.leftAnchor, constant: 25).isActive = true
        v.rightAnchor.constraint(equalTo: toolBar.rightAnchor, constant: -25).isActive = true
        
        tableNode.view.separatorStyle = .none
    }
    
    private func setEmptyView() {
        let emptyView = UIView(
            frame: CGRect(
                x: tableNode.view.center.x, y: tableNode.view.center.y,
                width: tableNode.view.bounds.size.width, height: tableNode.view.bounds.size.height
            )
        )
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(r: 128, g: 128, b: 128)
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 21)
        
        emptyView.addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true

        titleLabel.text = "No Events"

        tableNode.view.backgroundView = emptyView
    }
    
    private func removeEmptyView() {
        tableNode.view.backgroundView = nil
    }
        
    // MARK: - TableNode Delegate
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let c = content[indexPath.row]
        let node = EventPreviewNode()
        
        let daysString = DateHelper.formatDateToPreviewString(c.date!)
        node.setNode(
            name: c.name ?? "", days: daysString, bg: UIImage(named: "2")
        )
        
        return node
    }
    
    // MARK: - Actions
    
    @objc private func openSettings() {
        let c = UINavigationController(rootViewController: SettingsController(withTableStyle: .grouped))
        present(c, animated: true, completion: nil)
    }
    
    @objc private func newEvent() {
        let c = UINavigationController(rootViewController: NewEventController(withTableStyle: .grouped))
        c.modalPresentationStyle = .fullScreen
        
        present(c, animated: true, completion: nil)
    }
}

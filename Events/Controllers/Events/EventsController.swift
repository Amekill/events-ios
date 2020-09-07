//
//  EventsController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/11/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit
import SPLarkController
import RxCocoa
import RxSwift

class EventsController: TableNodeController {
    
    private var content = [EventModel]()
    private let disposeBag = DisposeBag()
    private var eventsObject: Disposable?
    
    deinit {
        eventsObject?.dispose()
    }
    
    private func loadEvents() -> Disposable {
        eventsObject?.dispose()
        
        let s = DefaultStorage.shared.get(forKey: .sortedBy)
        let type = SettingsContentType.SortType(rawValue: s ?? "") ?? .date
        
        return RealmManager.shared.event.getEvents(sortBy: type) { events in
            self.content.removeAll(keepingCapacity: true)
            
            for e in events {
                let event = self.rlmToLocal(e)
                self.content.append(event)
            }

            self.reloadTableNode()
        }.subscribe(onNext: { array, changes in
            for d in changes.deleted {
                self.content.remove(at: d)
            }
            
            for i in changes.inserted {
                let event = self.rlmToLocal(array[i])
                self.content.insert(event, at: i)
            }
            
            for u in changes.updated {
                self.content[u] = self.rlmToLocal(array[u])
            }
            
            self.tableNode.performBatchUpdates({
                self.tableNode.deleteRows(at: changes.deleted.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self.tableNode.insertRows(at: changes.inserted.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                self.tableNode.reloadRows(at: changes.updated.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
            }, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        appReturnedFromBackground()
            .subscribe(onNext: { _ in
                self.reloadTableNode()
            })
        .disposed(by: disposeBag)
        
        eventsObject = loadEvents()
        subscribeToSortUpdating()
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
    
    override func loadView() {
        super.loadView()
        setColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if content.isEmpty { setEmptyView()  } else { removeEmptyView() }
        reloadTableNode()
        animate()
    }
    
    private func animate() {
        guard let coordinator = self.transitionCoordinator else {
            return
        }

        coordinator.animate(alongsideTransition: {
            [weak self] context in
            self?.setColors()
        }, completion: nil)
    }

    private func setColors() {
        navigationController?.navigationBar.tintColor = .black
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
        navBar.barStyle = .default
        
        navBar.backIndicatorImage = UIImage(named: "i_arrow_back_white")
        navBar.backIndicatorTransitionMaskImage = UIImage(named: "i_arrow_back_white")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        navBar.prefersLargeTitles = true
        title = "All Events"
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
        
        let footerView = UIView()
        footerView.backgroundColor = view.backgroundColor
        footerView.frame = CGRect(x: 0, y: 100, width: 200, height: 200)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolBar)
        view.addSubview(footerView)
        
        tableNode.contentInset.bottom = 50
        let guide = self.view.safeAreaLayoutGuide
        
        toolBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        footerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        footerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        footerView.topAnchor.constraint(equalTo: toolBar.bottomAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        v.centerYAnchor.constraint(equalTo: toolBar.centerYAnchor).isActive = true
        v.leftAnchor.constraint(equalTo: toolBar.leftAnchor, constant: 18).isActive = true
        v.rightAnchor.constraint(equalTo: toolBar.rightAnchor, constant: -18).isActive = true
        
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
        tableNode.view.isScrollEnabled = false
    }
    
    private func removeEmptyView() {
        tableNode.view.backgroundView = nil
        tableNode.view.isScrollEnabled = true
    }
    
    private func appReturnedFromBackground() -> Observable<Notification> {
        return Observable.create( { observer in
            let n = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { notification in
                observer.onNext(notification)
            }
            
            return Disposables.create {
                NotificationCenter.default.removeObserver(n)
            }
        })
    }
    
    private func sortingDidChanged() -> Observable<Void> {
        return Observable.create( { observer in
            let n = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "N_SORTING_CHANGED"), object: nil, queue: nil) { _ in
                observer.onNext(())
            }
            
            return Disposables.create {
                NotificationCenter.default.removeObserver(n)
            }
        })
    }
    
    private func subscribeToSortUpdating() {
        sortingDidChanged()
            .subscribe(onNext: {
                self.eventsObject = self.loadEvents()
            })
        .disposed(by: disposeBag)
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
            name: c.name ?? "", days: daysString, bg: c.image
        )
        
        return node
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        TapticHelper.generateImpact(style: .light)
        
        let event = content[indexPath.row]
        let c = EventFullController()
        c.event = event

        navigationController?.pushViewController(c, animated: true)
    }
    
    // MARK: - Actions
    
    @objc private func openSettings() {
        TapticHelper.generateImpact(style: .light)
        
        let c = SettingsController()
        presentAsLark(c)
    }
    
    @objc private func newEvent() {
        TapticHelper.generateImpact(style: .light)
        
        let c = UINavigationController(rootViewController: NewEventController(withTableStyle: .grouped))
        present(c, animated: true, completion: nil)
    }
}

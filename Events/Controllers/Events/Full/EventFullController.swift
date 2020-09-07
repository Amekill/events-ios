//
//  EventFullController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/16/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit
import RxSwift
import RealmSwift
import RxRealm

class EventFullController: ASViewController<ASDisplayNode> {
    
    var event: EventModel?
    
    private let backgroundImage = ASImageNode()
    private let statusBarShadow = ASImageNode()
    private let elementsShadow = ASImageNode()
    private let elementsNode = EventFullNode()
    
    private let disposeBag = DisposeBag()
    
    init() {
        let n = ASDisplayNode()
        super.init(node: n)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateContent()
        
        startUpdating()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.barTintColor = .white // previous color
        navigationController?.navigationBar.barStyle = .default

        super.willMove(toParent: parent)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animate()
        updateContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setColors()
    }
    
    override func loadView() {
        super.loadView()
        setColors()
    }
    
    private func animate() {
        guard let coordinator = self.transitionCoordinator else {
            return
        }
        
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.setColors()
        }, completion: nil)
    }

    private func setColors() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func updateUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "i_more_white"), style: .plain, target: self, action: #selector(moreActions)
        )
        
        backgroundImage.frame = view.frame
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        
        let screen = UIScreen.main.bounds
        let height = (screen.height / 2) * 0.5
        elementsNode.frame = CGRect(x: 0, y: screen.height - height, width: screen.width, height: height)
        
        statusBarShadow.frame = CGRect(x: 0, y: -5, width: screen.width, height: 140)
        statusBarShadow.image = UIImage(named: "shadow")
        statusBarShadow.contentMode = .scaleAspectFill
        statusBarShadow.view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        elementsShadow.frame = elementsNode.frame
        elementsShadow.image = UIImage(named: "shadow_bottom")
        elementsShadow.contentMode = .scaleAspectFill
        
        elementsNode.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeTimeStyle)))
        
        node.addSubnode(backgroundImage)
        node.addSubnode(statusBarShadow)
        node.addSubnode(elementsShadow)
        node.addSubnode(elementsNode)
    }
    
    func updateContent() {
        backgroundImage.image = event?.image ?? UIImage(named: "placeholder")
        
        let time = DateHelper.format(date: event?.date ?? Date(), style: event?.dateFormat ?? .days)
        elementsNode.setNode(
            time: time, name: event?.name ?? "",
            date: DateHelper.formatDate(event?.date ?? Date(), format: "MMMM dd, YYYY / H:mm")
        )
    }
    
    private func startUpdating() {
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        .subscribe({ _ in
            self.updateContent()
        }).disposed(by: disposeBag)
    }
}

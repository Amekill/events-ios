//
//  EventFullController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/16/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit
import Hero

class EventFullController: ASViewController<ASDisplayNode> {
    
    var event: EventModel?
    
    private let backgroundImage = ASImageNode()
    private let elementsNode = EventFullNode()
    
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
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.barTintColor = .white // previous color
        navigationController?.navigationBar.barStyle = .default

        super.willMove(toParent: parent)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animate()
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
        
        backgroundImage.image = UIImage(named: "2")
        backgroundImage.frame = view.frame
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        
        let screen = UIScreen.main.bounds
        let height = (screen.height / 2) * 0.5
        elementsNode.frame = CGRect(x: 0, y: screen.height - height, width: screen.width, height: height)
        
        node.addSubnode(backgroundImage)
        node.addSubnode(elementsNode)
    }
}

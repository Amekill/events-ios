//
//  TableNodeController.swift
//  Events
//
//  Created by Alexey Kostenko on 6/11/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

class TableNodeController: ASViewController<ASDisplayNode>, ASTableDelegate, ASTableDataSource {
    
    let tableNode: ASTableNode!
    
    init() {
        tableNode = ASTableNode(style: .plain)
        super.init(node: tableNode)
        
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    init(withTableStyle tableStyle: UITableView.Style) {
        tableNode = ASTableNode(style: tableStyle)
        super.init(node: tableNode)
        
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, didUnhighlightRowAt indexPath: IndexPath) { }
    
    func tableNode(_ tableNode: ASTableNode, didHighlightRowAt indexPath: IndexPath) {
        let node = tableNode.nodeForRow(at: indexPath)
        node?.backgroundColor = tableNode.backgroundColor
    }
    
    func reloadTableNode() {
        DispatchQueue.main.async {
            self.tableNode.reloadData()
        }
    }
}

extension TableNodeController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

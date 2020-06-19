//
//  EventFullController + Actions.swift
//  Events
//
//  Created by Alexey Kostenko on 6/17/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

// MARK: - Actions

extension EventFullController {
    
    @objc func moreActions() {
        TapticHelper.generateImpact(style: .light)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(
            title: "Edit", style: .default, handler: { _ in
                self.editEvent()
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "Delete", style: .destructive, handler: { _ in
                self.confirmDelete()
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "Cancel", style: .cancel, handler: nil
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func confirmDelete() {
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete?", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(
            title: "Cancel", style: .cancel, handler: nil
        ))
        
        alert.addAction(UIAlertAction(
            title: "Delete", style: .destructive, handler: { _ in
                self.deleteEvent()
            }
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteEvent() {
        RealmManager.shared.event.deleteEvent(withId: event?.id ?? 0)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func editEvent() {
        guard let event = event else {
            return
        }
        
        let c = NewEventController(withTableStyle: .grouped)
        c.eventModel = event
        c.editorMode = true
        
        present(UINavigationController(rootViewController: c), animated: true, completion: nil)
    }
    
    @objc func changeTimeStyle() {
        TapticHelper.generateImpact(style: .light)
        let styles: [EventDateFormat] = [.days, .weeksDays, .monthsDays, .monthsWeeks, .yearsMonths]
        
        // get current index
        var nextStyle: EventDateFormat? {
            if let i = styles.firstIndex(where: { $0 == event?.dateFormat }) {
                let maxIndex = styles.count - 1
                if i < maxIndex {
                    return styles[i + 1]
                } else {
                    return styles[0]
                }
            }
            
            return nil
        }
        
        event?.dateFormat = nextStyle ?? .days
        
        RealmManager.shared.event.updateEvent(event!)
        updateContent()
    }
}

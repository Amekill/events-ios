//
//  NewEventController + Actions.swift
//  Events
//
//  Created by Alexey Kostenko on 6/14/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import AsyncDisplayKit

// MARK: - Actions

extension NewEventController {
    
    @objc func dismissController() {
        TapticHelper.generateImpact(style: .light)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showDatePicker(_ startDate: Date? = nil) {
        dismissKeyboard()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: 30, width: 270, height: 200)
        datePicker.date = startDate == nil ? Date() : startDate!
        
        let alertController = UIAlertController(title: "Select date", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alertController.view.addSubview(datePicker)
                
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.showTimePicker(datePicker.date, forRent: !(startDate == nil))
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func showTimePicker(_ date: Date, forRent: Bool) {
        dismissKeyboard()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.frame = CGRect(x: 0, y: 30, width: 270, height: 200)

        datePicker.date = date
        
        let alertController = UIAlertController(title: "Select time", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alertController.view.addSubview(datePicker)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let node = self.tableNode.nodeForRow(at: IndexPath(row: 2, section: 0)) as? NewSelectionNode {
                let date = DateHelper.formatDate(datePicker.date, format: "dd.MM.yyyy HH:mm")
                node.setNode(title: "Date", subtitle: date)
                
                self.eventModel.date = datePicker.date
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithSelectingImageSource() {
        dismissKeyboard()
        
        let alert = UIAlertController(
            title: "Select image source", message: nil, preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(
            title: "Library", style: .default, handler: { _ in
                self.imagePicker?.present(for: .photoLibrary)
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "Camera", style: .default, handler: { _ in
                self.imagePicker?.present(for: .camera)
            }
        ))
        
//        alert.addAction(UIAlertAction(
//            title: "Network", style: .default, handler: { _ in
//
//            }
//        ))
        
        alert.addAction(UIAlertAction(
            title: "Cancel", style: .cancel, handler: nil
        ))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func createEvent() {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        
        guard eventModel.name != nil else {
            Utilities.showAlertController(
                onController: self, withTitle: "Error", message: "The field name must be filled!"
            )
            notificationFeedbackGenerator.notificationOccurred(.warning)
            
            return
        }
        
        guard eventModel.category != nil else {
            Utilities.showAlertController(
                onController: self, withTitle: "Error", message: "The field category must be selected!"
            )
            notificationFeedbackGenerator.notificationOccurred(.warning)
            
            return
        }
        
        guard eventModel.date != nil else {
            Utilities.showAlertController(
                onController: self, withTitle: "Error", message: "The field date must be selected!"
            )
            notificationFeedbackGenerator.notificationOccurred(.warning)
            
            return
        }
        
        guard eventModel.notifications != nil else {
            Utilities.showAlertController(
                onController: self, withTitle: "Error", message: "The field notification must be selected!"
            )
            notificationFeedbackGenerator.notificationOccurred(.warning)
            
            return
        }
        
        DataManager.shared.events.array.append(eventModel)
        
        dismissController()
        notificationFeedbackGenerator.notificationOccurred(.success)
    }
}

//
//  NewEventController + ImagePicker.swift
//  Events
//
//  Created by Alexey Kostenko on 6/15/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

extension NewEventController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        eventModel.image = image
    }
}

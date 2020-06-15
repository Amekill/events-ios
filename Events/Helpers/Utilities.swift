//
//  Utilities.swift
//  Events
//
//  Created by Alexey Kostenko on 6/15/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

struct Utilities {
    
    static func showAlertController(onController controller: UIViewController, withTitle title: String?, message: String?) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let close = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(close)
            
            controller.present(ac, animated: true, completion: nil)
        }
    }
}

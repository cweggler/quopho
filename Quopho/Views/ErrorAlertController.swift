//
//  ErrorAlertController.swift
//  Quopho
//
//  Created by Cara on 5/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class ErrorAlertController {
    
    // convenience class for showing error alert dialogs that's why it's static
    
    static func alert(title: String = "Error", message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}

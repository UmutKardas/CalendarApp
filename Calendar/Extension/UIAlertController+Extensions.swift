//
//  UIAlertController+Extensions.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 19.12.2024.
//

import UIKit

extension UIAlertController {
    static func showAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        return alertController
    }
}

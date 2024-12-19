//
//  UIToolbar+Extensions.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 19.12.2024.
//

import UIKit

extension UIToolbar {
    static func doneToolbar(target: Any, action: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
}

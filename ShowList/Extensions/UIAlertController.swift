//
//  UIAlertController.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    func show() {
        if let topController = UIApplication.topViewController() {
            topController.present(self, animated: true, completion: nil)
        }
    }
    
    class func alert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            (result: UIAlertAction) -> Void in
        })
        alert.show()
    }
}

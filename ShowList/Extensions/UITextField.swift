//
//  UITextField.swift
//  ShowList
//
//  Created by Влад Дудин on 8/4/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    var safeText: String {
        return self.text ?? String()
    }
}

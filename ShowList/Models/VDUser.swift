//
//  VDUser.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import Foundation
import UIKit

struct UserResponse: Codable {
    var data : [VDUser]
}

struct VDUser : Codable {
    var name: String
    var imagePath: String!
    var id: String
}

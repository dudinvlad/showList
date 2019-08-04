//
//  Constants.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import Foundation

//MARK: - API
enum API: String {
    case imageUrl = "http://download.glide.me/pre-login-avatars/avatars_cartoon_animals_%@.png"
}

//MARK: - Files
enum FileExtension: String {
    case json
}

//MARK: - CoreData

struct EntityNames {
    static let users = "User"
}

//MARK: - toryboards

struct Storyboards {
    static let main = "Main"
}

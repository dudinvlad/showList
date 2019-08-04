//
//  VDDataManager.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import Foundation
import UIKit

let launcheOnceKey = "isAppAlreadyLaunchedOnce"
let shownAlertKey = "isAlertAlreadyShown"

class VDDataManager {

    fileprivate let usersData = "personsData"
    static let shared = VDDataManager()
    
    func fetchAndSaveUsers() {
        if let url = Bundle.main.url(forResource: usersData, withExtension: FileExtension.json.rawValue) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let reponse = try decoder.decode(UserResponse.self, from: data)
                VDCoreDataManager.shared.save(reponse.data)
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func isPerformed(by key:String) -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: key){
            return true
        } else {
            defaults.set(true, forKey: key)
            return false
        }
    }
}

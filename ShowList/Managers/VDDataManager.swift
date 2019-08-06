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
    
    func fetchAndSaveUsers(with completion: @escaping (() -> Void)) {
        if let url = Bundle.main.url(forResource: usersData, withExtension: FileExtension.json.rawValue) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(UserResponse.self, from: data)
                loadPhotos(for: response.data) { (imagesData) in
                    VDCoreDataManager.shared.save(response.data, imagesData)
                    completion()
                }
            } catch {}
        }
    }
    
    func loadPhotos(for response: [VDUser], completion: @escaping (([Data]) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let downloadGroup = DispatchGroup()
            var imagesData = [Data]()
            for user in response {
                let imageURLString = String(format: API.imageUrl.rawValue, user.id)
                guard let url = URL(string: imageURLString) else {return}
                downloadGroup.enter()
                let imageData = try! Data(contentsOf: url)
                imagesData.append(imageData)
                downloadGroup.leave()
            }
            downloadGroup.notify(queue: .main, execute: {
                completion(imagesData)
            })
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

//
//  VDRouter.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import Foundation
import UIKit

class VDRouter {
    
    let navigationController: UINavigationController?
    
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public
    
    func setListScreen() {
        let listViewController = viewController(storyboard: Storyboards.main, type: VDListTableViewController.self)
        let listNavigationController = UINavigationController(rootViewController: listViewController)
        UIApplication.shared.delegate?.window??.rootViewController = listNavigationController
    }
    
    func showEditScreen(with item: User?) {
        let editViewController = viewController(storyboard: Storyboards.main, type: VDEditViewController.self)
        editViewController.person = item
        navigationController?.pushViewController(editViewController, animated: true)
    }
    
    //MARK: - Private
    
    private func viewController<T>(storyboard: String, type: T.Type) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
        assert(viewController != nil, "Can't get \(String(describing: T.self)) viewcontroller from \(storyboard) storyboard")
        return viewController!
    }
}

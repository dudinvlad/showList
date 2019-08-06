//
//  VDLaunchViewController.swift
//  ShowList
//
//  Created by Влад Дудин on 8/6/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import UIKit

class VDLaunchViewController: VDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    // MARK: - Private
    
    private func initialSetup() {
        loadUsersOnce()
    }
    
    private func setMainScreen() {
        router.setListScreen()
    }
    
    func loadUsersOnce() {
        if !VDDataManager.shared.isPerformed(by: launcheOnceKey) {
            VDDataManager.shared.fetchAndSaveUsers { [weak self] in
                UIAlertController.alert(message:"Welcome!")
                self?.setMainScreen()
            }
        } else {
            self.setMainScreen()
        }
    }

}

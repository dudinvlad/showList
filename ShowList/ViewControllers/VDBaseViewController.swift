//
//  VDBseViewController.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import UIKit

class VDBaseViewController: UIViewController {
    
    lazy var router : VDRouter = {
       VDRouter(self.navigationController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultNavigationAppearance()
    }
    

    // MARK: - Private
    
    func largeTitleSetup(_ isLarge: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = isLarge
    }
    
    private func defaultNavigationAppearance() {
        self.navigationController?.view.backgroundColor = .white
    }
}

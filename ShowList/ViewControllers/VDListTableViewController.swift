//
//  VDListTableViewController.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import UIKit
import CoreData

class VDListTableViewController: VDBaseViewController {
    
    var dataSource = [User]()
    let alertMessage = "Welcome!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSourceSetup()
        largeTitleSetup(true)
    }
    
    //MARK: - DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VDListTableViewCell.self), for: indexPath) as! VDListTableViewCell
        let person = self.dataSource[indexPath.row]
        cell.load(with: person)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.dataSource[indexPath.row]
        router.showEditScreen(with: person)
    }
    
    //MARK: - Private
    
    private func initialSetup() {
        refreshControlSetup()
    }
    
    private func refreshControlSetup() {
        self.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func dataSourceSetup() {
        VDCoreDataManager.shared.fetchUsers { (data) in
            if let users = data {
                if !VDDataManager.shared.isPerformed(by: shownAlertKey) {
                    UIAlertController.alert(message: alertMessage)
                }
                dataSource = users
                tableView.reloadData()
            }
        }
    }
    
    @objc private func refreshAction() {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

}

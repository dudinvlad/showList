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
    
    let alertMessage = "Welcome!"
    let fetchedController = VDCoreDataManager.shared.fetchedResultController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        largeTitleSetup(true)
    }
    
    //MARK: - DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let users = fetchedController.sections?[section]
        return users?.numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: VDListTableViewCell.self), for: indexPath) as! VDListTableViewCell
        let person = fetchedController.object(at: indexPath) as? User
        cell.load(with: person)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = fetchedController.object(at: indexPath) as? User
        router.showEditScreen(with: person)
    }
    
    //MARK: - Private
    
    private func initialSetup() {
        refreshControlSetup()
        fetchedControllerSetup()
    }
    
    private func refreshControlSetup() {
        self.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    private func fetchedControllerSetup() {
        do {
         try fetchedController.performFetch()
        } catch {
            UIAlertController.alert(message: "Fail to load users!")
        }
        fetchedController.delegate = self
    }
    
    @objc private func refreshAction() {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

}

extension VDListTableViewController : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .update:
            guard let indexPath = indexPath else {return}
            let cell = tableView.cellForRow(at: indexPath) as! VDListTableViewCell
            let person = self.fetchedController.object(at: indexPath) as? User
            cell.load(with: person)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
}

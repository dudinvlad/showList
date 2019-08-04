//
//  VDEditViewController.swift
//  ShowList
//
//  Created by Влад Дудин on 8/3/19.
//  Copyright © 2019 Vlad Dudin. All rights reserved.
//

import UIKit

class VDEditViewController: UIViewController {
    
    var person: User?
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let newName = nameTextField.safeText.count > 0 ? nameTextField.safeText : person?.name
        VDCoreDataManager.shared.update(self.person, name: newName)
    }
    
    //MARK: - Private
    
    private func initialSetup() {
        textFieldSetup()
        navigationBarSetup()
    }
    
    private func textFieldSetup() {
        nameTextField.delegate = self
        nameTextField.text = person?.name
    }
    
    private func navigationBarSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension VDEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        return true
    }
}

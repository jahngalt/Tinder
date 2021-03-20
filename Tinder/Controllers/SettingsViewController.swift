//
//  SettingsViewController.swift
//  Tinder
//
//  Created by Oleg Kudimov on 3/20/21.
//

import UIKit

class SettingsViewController: UITableViewController {

    fileprivate func settingNavigationItems() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleCancel)),
            UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleCancel))
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigationItems()
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true , completion: nil)
    }
}
